"""Verify Cards, exact public mod pins and both supported index addresses anonymously."""
import hashlib,json,urllib.request
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
ROOT=Path(__file__).resolve().parents[1]
DESTINATIONS=[('kasc-cards','v1.3.3'),('kanto-ascendant','v6.7.17'),('voxel-ascendant','v3.0.35')]
def get(url):
    with urllib.request.urlopen(url,timeout=60) as response:return response.read()
def check(line):
    digest,path=line.split();name=Path(path).name
    assert hashlib.sha256((ROOT/path).read_bytes()).hexdigest()==digest
    for repo,tag in DESTINATIONS:
        url=f'https://github.com/Roxas2712/{repo}/releases/download/{tag}/{name}'
        assert hashlib.sha256(get(url)).hexdigest()==digest,url
    return name
if __name__=='__main__':
    with ThreadPoolExecutor(max_workers=3) as pool:files=list(pool.map(check,(ROOT/'SHA256SUMS.txt').read_text().splitlines()))
    for address in ['https://raw.githubusercontent.com/Roxas2712/kasc-cards/main/kasc-card-index.json','https://raw.githubusercontent.com/Roxas2712/kanto-ascendant/codex/kasc-6.7-card-distribution/kasc-card-index.json']:
        assert get(address)==(ROOT/'kasc-card-index.json').read_bytes(),address
    for repo,tag in DESTINATIONS:
        base=f'https://github.com/Roxas2712/{repo}/releases/download/{tag}/'
        for name in ['kasc-card-index.json','SHA256SUMS.txt']:
            remote_name = 'KASC-Cards-1.3.3-SHA256SUMS.txt' if name == 'SHA256SUMS.txt' and repo != 'kasc-cards' else name
            assert get(base+remote_name)==(ROOT/name).read_bytes()
    for key,repo in [('kasc','kanto-ascendant'),('vasc','voxel-ascendant')]:
        expected=json.loads((ROOT/'verification-data/PACKAGE-RECEIPTS.json').read_text())[key]
        release=json.loads(get(f'https://api.github.com/repos/Roxas2712/{repo}/releases/tags/v'+expected['version']))
        asset=next(a for a in release['assets'] if a['name']==expected['file'])
        assert asset['digest']=='sha256:'+expected['sha256']
    latest=json.loads(get('https://api.github.com/repos/Roxas2712/kasc-cards/releases/latest'))
    assert latest['tag_name']=='v1.3.3' and not latest['prerelease'] and not latest['draft']
    assert len((ROOT/'DISCORD-EN.md').read_text())<=2000
    print(json.dumps(dict(status='PASS',files=files,allThreeReleaseDownloads=True,bothPublicIndexesExact=True,publicModHashesVerified=True,publicStableLatest=True),indent=2))

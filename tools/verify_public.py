"""Verify new Card and matching KASC release Card downloads anonymously."""
import hashlib,json,urllib.request
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
ROOT=Path(__file__).resolve().parents[1]
def get(url):
    with urllib.request.urlopen(url,timeout=90) as r:return r.read()
def check(line):
    digest,path=line.split();name=Path(path).name
    assert hashlib.sha256((ROOT/path).read_bytes()).hexdigest()==digest
    for repo,tag in [('kasc-cards','v1.3.0-rc.7'),('kanto-ascendant','v6.7.0-rc.7')]:
        url=f'https://github.com/Roxas2712/{repo}/releases/download/{tag}/{name}'
        assert hashlib.sha256(get(url)).hexdigest()==digest,url
    return name
if __name__=='__main__':
    lines=(ROOT/'SHA256SUMS.txt').read_text().splitlines()
    with ThreadPoolExecutor(max_workers=3) as pool:files=list(pool.map(check,lines))
    feed=get('https://raw.githubusercontent.com/Roxas2712/kasc-cards/main/kasc-card-index.json')
    assert feed==(ROOT/'kasc-card-index.json').read_bytes()
    old=get('https://raw.githubusercontent.com/Roxas2712/kanto-ascendant/codex/kasc-6.7-card-distribution/kasc-card-index.json')
    assert len(json.loads(old)['carts'])==3
    release=json.loads(get('https://api.github.com/repos/Roxas2712/kasc-cards/releases/tags/v1.3.0-rc.7'))
    assert not release['prerelease'] and not release['draft']
    latest=json.loads(get('https://api.github.com/repos/Roxas2712/kasc-cards/releases/latest'))
    assert latest['tag_name']=='v1.3.0-rc.7'
    assert len((ROOT/'DISCORD-EN.md').read_text())<=2000
    print(json.dumps(dict(status='PASS',files=files,newAndOriginalDownloads=True,
      publicIndexExact=True,originalIndexAvailable=True,publicStableLatest=True,
      discordWithin2000Characters=True),indent=2))

import urllib.request

versions = ['8.14', '8.14.0', '8.14.1', '8.13', '8.13.0', '8.12', '8.12.0', '8.11', '8.11.0', '8.10.2']

for v in versions:
    url = f'https://services.gradle.org/distributions/gradle-{v}-all.zip'
    try:
        with urllib.request.urlopen(url, timeout=20) as r:
            print(v, r.status, r.geturl())
    except Exception as e:
        print(v, 'ERROR', type(e).__name__, e)

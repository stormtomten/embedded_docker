# Docker-filer för C/C++ i raspberrymiljö
Gör i stort sett vad instruktionerna (https://github.com/miwashi-edu/edu-pico-c/tree/level-2) säger, med några skillnader.

- Installerar inte Nano.
- Tillåter inte root-inloggning.
- Startar ssh vid uppstart.
- Användarnamn och lösenord är hårdkodat i imagefilen (alla containers från samma image har samma användare).


**Uppdatering**

Rättat ett fel i användarkonfigurationen.

## Instruktioner
### Clona repot
```bash
git clone "https://github.com/stormtomten/embedded_docker.git"
cd embedded_docker/src/
```
### Skapa Docker image
Ersätt **[user]**, **[password]** och **[imagename]** med egna värden.

```bash
docker build --build-arg USERNAME=[user] --build-arg PASSWORD=[password] -t [imagename] .
```
**Möjliga Varningar.**

- **Ej rekommenderat** att ange användarnamn och lösenord som argument.
- **Processor-arkitekturen** (arm64) skiljer sig från din dators.

### Starta Docker container
Ersätt **[containername]**, **[hostname]** och **[port]** med egna värden, se till att dessa inte krockar med tidigare instanser.

Använd ett befintligt nätverk i **[networkname]** (ni har troligtvis ```iotnet``` sedan tidigare).

```bash
docker run -d --name [containername] --network [networkname] --hostname [hostname] -p [port]:22 -e TZ=UTC [imagename]
```
- -e TZ=UTC - Sätter tidszonen till UTC för containern

### Login
```bash
ssh [user]@localhost -p [port]

```
**Om du får följande:**

```WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!```

Ta bort de gamla SSH-nycklarna:

```bash
# Öppna known_host och ta bort nycklarna för localhost:[port]
vi ~/.ssh/known_hosts
# Sök efter raderna med 'localhost:[port]' och radera dem.
```

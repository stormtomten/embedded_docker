# Docker-filer för C/C++ i raspberrymiljö
Gör i stort sett vad instruktionerna (https://github.com/miwashi-edu/edu-pico-c/tree/level-2) säger, med några skillnader.

- Installerar inte Nano.
- Tillåter inte root-inloggning.
- Startar ssh vid uppstart.
- Användarnamn och lösenord är hårdkodadt i imagefilen (alla containers från samma image har samma användare).


**Uppdatering**
Rättat ett fel i användarkonfigurationen.

## Instruktioner
### Clona repot
```bash
git clone "https://github.com/stormtomten/embedded_docker.git"
cd embedded_docker/src/
```
### Skapa Docker image
[...] är variabler ni själva får sätta. Se till att dessa inte krockar med tidigare instanser.
Sätt [user] [password] och [buildname] till egna värden.
```bash
docker build --build-arg USERNAME=[user] --build-arg PASSWORD=[password] -t [buildname] .
```
- En/två varningar förekommer:
    - Ej rekommenderat att ange användarnamn och lösenord som argument.
    - **Processor-arkitekturen** skiljer sig från din dators (basen är arm64).

### Starta Docker container

```bash
docker run -d --name [containername] --network [networkname] --hostname [hostname] -p [port]:22 -e TZ=UTC [buildname]
```
# Ni har nog ett iotnet sedan tidigare använd det i [networkname]
- [networkname] - Använd ett befintligt (iotnet om det är konfigurerat).
- -e TZ=UTC - Sätter tidszonen till UTC för containern

### Login
```bash
ssh [user]@localhost -p [port]

```
Om du får följande:
WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!
```bash
# Öppna known_host och ta bort nycklarna för localhost:[port]
vi ~/.ssh/known_hosts
# Sök efter raden/raderna me 'localhost:[port]' och radera den/dem.
```

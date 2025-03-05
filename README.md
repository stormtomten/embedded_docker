# Docker-filer för C/C++ i raspberrymiljö
Gör i stort sätt vad instruktionerna (https://github.com/miwashi-edu/edu-pico-c/tree/level-2) säger, med några skillnader.

- Installerar inte Nano
- Tillåter inte root inloggning
- Startar ssh vid uppstart
- Användarnamn och lösenord blir hårdkodat i imagefilen (en ny container kommer ha samma användare).

## Instruktioner
### Clona repot
```bash
git clone "https://github.com/stormtomten/embedded_docker.git"
cd embedded_docker/src/
```
### Skapa Docker image
[...] är variabler ni själva får sätta. Se till att dessa inte krockar med tidigare instanser.
```bash
docker build --build-arg USERNAME=[user] --build-arg PASSWORD=[password] -t [buildname] .
# Sätt [user] [password] och [buildname] till vad ni vill ha.
# Ger en/två varningar:
# - Ej rekommenderat att ge användarnamn och lösenord som argument
# - Varning för processor arkitektur som kanske inte matchar din dators (basen är arm64)
```
### Starta Docker container

```bash
docker run -d --name [containername] --network [networkname] --hostname [hostname] -p [port]:22 -e TZ=UTC [buildname]
# Ni har nog ett iotnet sedan tidigare använd det i [networkname]
# ('-e TZ=UTC' sätter tidszonen till UTC för containern.)
```

### Login
```bash
ssh [user]@localhost -p [port]

# if WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!
# vi ~/.ssh/known_hosts
# remove key for localhost:2222
```

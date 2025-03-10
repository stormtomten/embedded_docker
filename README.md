# Docker-filer för C/C++ i raspberrymiljö
~~Gör i stort sett vad instruktionerna (https://github.com/miwashi-edu/edu-pico-c/tree/level-2) säger, med några skillnader.~~

Följer de [uppdaterade instruktionerna](https://github.com/miwashi-edu/edu-raspberry-os).

- Tillåter inte root-inloggning.
- Startar ssh vid uppstart.
- Användarnamn och lösenord är hårdkodat i imagefilen (alla containers från samma image har samma användare).


## Instruktioner
### Clona repot
```sh
git clone "https://github.com/stormtomten/embedded_docker.git"
cd embedded_docker/src/
```
### Skapa Docker image
Ersätt **[user]**, **[password]** och **[imagename]** med egna värden.

```sh
docker build --build-arg USERNAME=[user] --build-arg PASSWORD=[password] -t [imagename] .
```
**Möjliga Varningar.**

- **Ej rekommenderat** att ange användarnamn och lösenord som argument.
- **Processor-arkitekturen** (arm64) skiljer sig från din dators.

### Starta Docker container
Ersätt **[containername]**, **[hostname]** och **[port]** med egna värden, se till att dessa inte krockar med tidigare instanser.

Använd ett befintligt nätverk i **[networkname]** (ni har troligtvis ```iotnet``` sedan tidigare).
```sh
docker network create --driver bridge --subnet 192.168.2.0/24 --gateway 192.168.2.1 iotnet
```


```sh
docker run -d --name [containername] --network [networkname] --hostname [hostname] -p [port]:22 -e TZ=UTC [imagename]
```
- -e TZ=UTC - Sätter tidszonen till UTC för containern

### Login
```sh
ssh [user]@localhost -p [port]

```
**Om du får följande:**

```WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!```

Ta bort de gamla SSH-nycklarna:

```sh
# Öppna known_host och ta bort nycklarna för localhost:[port]
vi ~/.ssh/known_hosts
# Sök efter raderna med 'localhost:[port]' och radera dem.
```

### Konfigurera Git
1. **Sätt standardbranch till ```main```:**
```sh
# Sätter default branch till main (istället för master)
git config --global init.defaulBranch main
```
2. **Ställ in användarnamn:**
```sh
git config --global user.name "Your Name"
```
Som email kan man använda en [GitHub noreply-mail](https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-personal-account-on-github/managing-email-preferences/setting-your-commit-email-address#about-no-reply-email)

```sh
curl -s https://api.github.com/users/[username] | grep -E '"id"|"login"'
```

Ger dig:
```json
  "login": "[username]",
  "id": [id],
```

```sh
git config --global user.email "your.email@example.com"
# Eller
git config --global user.email "[id]+[username]@users.noreply.github.com"

```
4. **Konfigurera GitHub-användare:**
```sh
git config --global github.user "[username]"
```
### Generera SSH-nyckel för GitHub
**Generera en ny nyckel:**
```sh
ssh-keygen -t ed25519 -C "your-email@example.com" -f ~/.ssh/id_ed25519 -N ""
```
- **-t** anger algoritm.
- **-C** lägger till en kommentar för identifiering, i detta fallet din email.
- **-f** anger var och vilket under vilket namn nyckeln sparas
- **-N ""** Ger lösenordet en tom sträng, inget lösenord behövs vid användning.

**Kopiera den genererade nyckeln.**
```sh
cat ~/.ssh/id_ed25519.pub
```

Lägg till nyckeln [här](https://github.com/settings/keys).

**Testa GitHub login.**
```sh
ssh -T git@github.com
```

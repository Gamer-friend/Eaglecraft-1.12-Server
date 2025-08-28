## >>SERVER INSTRUCTIONS START<<

First, go to the top of the repo (on the `master` branch) and click on code > codespaces > create codespace
now you have your own free server instance to host eaglercraft. Next you need to run the setup commands:

create 2 terminal tabs and paste in the following snipits:

first terminal: `cd server && sudo java -jar server.jar`
Once you did that, you need to wait for it to complete it. It should say "You need to agree to the eula to continue". IMPORTANT NOTE! [THIS IS FOR THE FIRST TERMINAL.] You need to agree to the eula in order for it to work. In your codespaces, go to the left sidebar and see the symbol that looks like two circles on top and one branch on the bottom, click on it, press the `+` on the `eula.txt` and write a commit message and click "commit". Rerun the server using `sudo java -jar server.jar`.

second terminal: `cd bungee && sudo java -jar bungee.jar`
Now go to the ports area and forward (MAKE SURE BOTH OF THEM ARE PUBLIC!) ports 25565 and 8081

## ⚠ MOST IMPORTANT! ⚠
Copy the 8081 port address and it should be like, for example, `https://eagtek-files-392jejdw-8081.app.github.dev` . Copy this and paste it in your ⚠⚠⚠ browser BUT DONT,  ⚠⚠⚠⚠ DO NOT PRESS `ENTER` YET!⚠⚠⚠⚠ Instead, replace the `https` (in the beginning of the port address) and replace it with a `wss` . Here is some examples:
❌ WRONG: `https://eagtek-files-392jejdw-8081.app.github.dev`
✅ CORRECT: `wss://eagtek-files-392jejdw-8081.app.github.dev`
This will be your server address! Like Minecraft, you can go to the servers, clicking add server, and pasting the address of the server, but we are talking about eaglecraft. If you have a Website that has eaglecraft already on it, feel free to use that. If you don't, and you wanna look smart at ur school then no worries, you can host your own website at [This repository.]()


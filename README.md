# pico8-deploy
## What the problem is
[PICO-8](https://www.lexaloffle.com/pico-8.php) is super minimalistic. While that's a good thing for development, deploying and rebuilding a project can be a bit involved.

## What this project does
This repo contains a single Makefile, which tries to provide a few useful targets to build and deploy a project (to [itch.io](https://itch.io/)).

## Prerequisites
- a standard version of Make for your system
- if you plan on deploying to itch.io, [butler](https://itch.io/docs/butler/) - run `butler login` before you use the Makefile
- well, PICO-8 and at least one .p8 file 😀

## Setup
First, let's do a little bit of setup:
- put the Makefile in your root carts folder (the one that you get when you run `folder` in PICO-8)
- for each project you're working on, create a folder and put the relevant .p8 file inside this folder
- create a Makefile (empty for now) in each one of your "project folder"

Now let's give make actual data:
In the "root Makefile", you'll see that there's a variable called `pico8`; this is where you tell make where `pico8-exe` (or whatever it is on your platform) is:
```Makefile
# just an example
pico8 = C://Users/USERNAME/Desktop/pico8.exe
```
In your "project Makefile" (the one that's empty in your project folder), add the two following variables:
```Makefile
# this is the name of the .p8 in this folder, without the extension
name = MY_FILE
# this is your username and the name of your project on itch.io
itchio = USERNAME/TEST-GAME
```
⚠ itch.io tends to convert the name of the project when there's underscores in it, replacing them with hyphens, so make sure you use the one that's shown in the URL and not the actual project name

⚠ also, make sure you created the project on itch.io before you deploy to it, because butler doesn't create it for you

## How to run
In the root carts folder, run
```sh
make TARGET project=FOLDER
```
to run the operation `TARGET` on the project `FOLDER_NAME`.

### List of useful targets
- **all**: exports `web` and `bin`
- **web**: exports `web`
- **bin**: exports `bin`
- **deploy**: exports and deploys `web` and `bin`
- **deploy_bin**: exports and deploys `bin`
- **deploy_web**: exports and deploys `web`
- **clean**: removes the exports for both `web` and `bin`
- **clean_web**: removes the exports for `web`
- **clean_bin**: removes the exports for `bin`

### Sample run
Given the following architecture:
```
ROOT_FOLDER/
 |_ Makefile
 |_ hello_world/
    |_ my_file.p8
    |_ Makefile
```
```Makefile
# hello_world/Makefile
name = my_file
itchio = tducasse/test-deploy
```
```sh
make deploy project=hello_world && make clean project=hello_world
```
![image](https://user-images.githubusercontent.com/11507599/120108688-ae218c00-c1a9-11eb-8aad-b86b9d7e4186.png)

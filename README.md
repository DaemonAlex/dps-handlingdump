<p align="center"><img src=".github/dps-logo.svg" alt="DelPerroSands" width="360"></p>

# dps-handlingdump

A one-off developer tool. It reads the stock handling of every vanilla vehicle and saves it to
one file.

## What it is for

When you tune vehicle handling you need to know what the game shipped with. The stock numbers
sit inside game archives and are slow to dig out. This tool asks the running game for them and
writes them down, so you have a clean baseline to compare against.

## What it does

- `/handlingdump` spawns each vehicle in `data/models.json` in front of you, one at a time.
- The vehicle is local. Other players do not see it. It is frozen, read, then deleted.
- It reads 42 decimal fields, 2 whole-number fields and 2 vector fields from `CHandlingData`,
  plus the vehicle class, type and display name.
- It sends the records to the server in batches of 20.
- The server writes `out/vanilla-handling.json` inside this resource. The file also holds the
  time, the game build, and a list of models that could not be read and why.

## On its own, and with other scripts

**On its own.** It works alone. It needs no framework, no inventory and no database.

**With handling packs or paid vehicle scripts.** It has no link to any of them. Run it with
your handling packs stopped if you want true stock numbers. The game returns whatever handling
is loaded at the time.

This is a tool you run once. Remove it from the server when you have the file.

## Requirements

- A FiveM server. Nothing else.
- The player who runs it needs the `command` ace (the usual admin group).

## Install

1. Put the folder in your resources and add `ensure dps-handlingdump`.
2. Make sure an `out` folder exists inside the resource.
3. Join the server, stand somewhere open, and type `/handlingdump`.
4. Watch the F8 console for progress. It prints a line every 50 vehicles.
5. When the server console says it has finished, copy `out/vanilla-handling.json`.
6. Remove the resource.

## Configuration

| Item | Meaning |
|---|---|
| `/handlingdump` | Starts the dump. In game only. Needs the `command` ace. One player at a time. |
| `data/models.json` | The list of vehicle model names to read. |
| `shared/fields.lua` | The handling fields that are read. Names must match the game exactly. |
| `CHUNK` in `client/main.lua` | How many records go to the server in one batch. 20. |
| `LOAD_TIMEOUT_MS` in `client/main.lua` | How long to wait for a model to load. 6000 ms. |

## Recent changes

- **12 November 2026.** README added.
- **25 October 2026.** First commit, as it runs on DelPerroSands.

## Author

Made by [DaemonAlex](https://github.com/DaemonAlex) for DelPerroSands.

## Other DPS scripts

All of these are made for DelPerroSands and run together on one Qbox server. Each one works on
its own. The ones marked "pairs with" do more when both are running.

| Script | What it does |
|---|---|
| [dps-inventory](https://github.com/DaemonAlex/dps-inventory) | The inventory: ox_inventory with equipment slots, backpacks, armour plates and a self status panel, in the DelPerroSands colours. |
| [dps-medical](https://github.com/DaemonAlex/dps-medical) | Patient records, illness and diagnostic tests. A companion to wasabi_ambulance. Pairs with dps-inventory: symptoms and diagnoses show on the status panel. |
| [dps-insurance](https://github.com/DaemonAlex/dps-insurance) | Ties m-Insurance into the MDT, impound, hospital and medical chart, and raises premiums for incidents other scripts report. Pairs with dps-medical and dps-fuel. |
| [dps-studio](https://github.com/DaemonAlex/dps-studio) | Build rooms, doors and portals in game from one panel (`/studio`), with owners and managers so staff do not have to support them. |
| [dps-shops](https://github.com/DaemonAlex/dps-shops) | Shop clerks who greet, react to robberies, talk back through dps-ainpcs and remember trouble, plus player-owned stores with delivery runs. Pairs with dps-ainpcs. |
| [dps-fleet](https://github.com/DaemonAlex/dps-fleet) | Vehicle browser and workshop on one panel: extras, liveries and mods for emergency vehicles. |
| [dps-parking](https://github.com/DaemonAlex/dps-parking) | Parking with valet, impound, violations and reserved spots. |
| [dps-vehiclepersistence](https://github.com/DaemonAlex/dps-vehiclepersistence) | Vehicles stay where they were parked. Pairs with dps-parking. |
| [dps-towjob](https://github.com/DaemonAlex/dps-towjob) | Queue-based tow job with jg-mechanic integration. |
| [dps-services](https://github.com/DaemonAlex/dps-services) | Request a tow and follow it live on the lb-phone and lb-tablet. Pairs with dps-towjob. |
| [dps-autoshops](https://github.com/DaemonAlex/dps-autoshops) | Self-service repair shops when no mechanic is on duty. |
| [dps-cityworker](https://github.com/DaemonAlex/dps-cityworker) | City infrastructure job and career. |
| [dps-ainpcs](https://github.com/DaemonAlex/dps-ainpcs) | NPCs you can talk to, with trust, quests and intel. Other scripts can make their own NPCs talk (dps-shops clerks). |
| [dps-badpeds](https://github.com/DaemonAlex/dps-badpeds) | Police interaction with NPCs: stops, arrests, intel and jail records. |
| [dps-gangwars](https://github.com/DaemonAlex/dps-gangwars) | Ambient gang NPCs, territory population and war reinforcements. |
| [dps-rotations](https://github.com/DaemonAlex/dps-rotations) | Moves dealers, harvests and other spots on a fixed schedule. |
| [dps-trains](https://github.com/DaemonAlex/dps-trains) | The train system. Pairs with dps-trains-stock, dps-traintools and dps-transitapp. |
| [dps-transitapp](https://github.com/DaemonAlex/dps-transitapp) | Live train arrival boards on the lb-phone. |
| [dps-faceplant](https://github.com/DaemonAlex/dps-faceplant) | City help, reports and staff tools on the lb-phone and lb-tablet. |
| [dps-chat](https://github.com/DaemonAlex/dps-chat) | A command box for voice-only servers. No chat feed. |
| [dps-filmmode](https://github.com/DaemonAlex/dps-filmmode) | One key hides every HUD layer and gives a smooth free camera for recording. |
| [dps-fuel](https://github.com/DaemonAlex/dps-fuel) | Gas station drive-offs for the ox_fuel nozzle: ripped hose, pump fire, station camera and a police call, by odds. Pairs with dps-insurance. |
| [dps-voice](https://github.com/DaemonAlex/dps-voice) | Spoken lines for NPCs, station announcements, dispatch and shops, from local voice models first. Pairs with dps-ainpcs. |
| [dps-bags](https://github.com/DaemonAlex/dps-bags) | Real bags for ox_inventory: the bag you carry shows on your character. |
| [dps-items](https://github.com/DaemonAlex/dps-items) | Item rules for ox_inventory: locked items, glovebox seats and an exploit watch. |
| [dps-furniture](https://github.com/DaemonAlex/dps-furniture) | Puts streamed furniture packs into the qs-housing furniture shop. |
| [dps-shellbrowser](https://github.com/DaemonAlex/dps-shellbrowser) | Staff tool to look at every qs-housing shell and set its door. |
| [dps-signs](https://github.com/DaemonAlex/dps-signs) | Rotates city messages across the SmartSigns road boards. |
| [dps-stationclear](https://github.com/DaemonAlex/dps-stationclear) | Hides map props that are in the way and keeps stray game peds off chosen spots. |
| [dps-citymap](https://github.com/DaemonAlex/dps-citymap) | A ready-made map of the whole city, cut into tiles for in-game screens. |
| [dps-cayo](https://github.com/DaemonAlex/dps-cayo) | Switches on the game's own Cayo Perico island, and nothing else. |
| [dps-aviation](https://github.com/DaemonAlex/dps-aviation) | Flight behaviour: aircraft idle instead of cutting out, sane taxi speed, a real start sequence. |
| [dps-airlines](https://github.com/DaemonAlex/dps-airlines) | Airlines job: passenger flights, cargo, charters, flight school and maintenance. |
| [dps-traintools](https://github.com/DaemonAlex/dps-traintools) | Rider tools for trains: board, sit, get off at a stop, ambient passengers. Pairs with dps-trains. |
| [dps-trains-stock](https://github.com/DaemonAlex/dps-trains-stock) | Train models and carriage sets for the train system. No scripts. Pairs with dps-trains. |
| [dps-traintracks](https://github.com/DaemonAlex/dps-traintracks) | Extra train track data. No scripts. Pairs with dps-trains. |
| [dps-crossings](https://github.com/DaemonAlex/dps-crossings) | Level crossings that close when a train comes. Pairs with dps-trains. |
| [dps-transit](https://github.com/DaemonAlex/dps-transit) | Passenger rail planning and scheduling (older system; dps-trains runs today). |
| [dps-maritime](https://github.com/DaemonAlex/dps-maritime) | Dock work and boat deliveries with progression. |
| [dps-maritime-maps](https://github.com/DaemonAlex/dps-maritime-maps) | Map files for the Jetsam docks, the map half of dps-maritime. |
| [dps-proracing](https://github.com/DaemonAlex/dps-proracing) | Circuit racing with lobbies, an AI practice grid and lap times. |
| [dps-carmenu](https://github.com/DaemonAlex/dps-carmenu) | Staff vehicle browser and spawner over the live Qbox vehicle list. |
| [dps-clothingbrowser](https://github.com/DaemonAlex/dps-clothingbrowser) | Staff tool to browse, identify and export clothing and uniforms. |
| [dps-lootpeds](https://github.com/DaemonAlex/dps-lootpeds) | Loot dead NPCs, with loot tables per model. |
| [dps-hookers](https://github.com/DaemonAlex/dps-hookers) | Adults-only RP (18+), adapted from MH Hookers by MaDHouSe. |
| [dps-weatherbridge](https://github.com/DaemonAlex/dps-weatherbridge) | Lets qb-weathersync and Renewed-Weathersync scripts work with night_natural_disasters. |
| [dps-fixes](https://github.com/DaemonAlex/dps-fixes) | Small server fixes kept in one resource. |
| [dps-bucketfix](https://github.com/DaemonAlex/dps-bucketfix) | Puts players back in the main world after spawning. |
| [dps-unfocus](https://github.com/DaemonAlex/dps-unfocus) | One key that frees a player stuck in a menu. |
| [dps-welcomecam](https://github.com/DaemonAlex/dps-welcomecam) | Aims the first camera a new player sees. |
| [dps-weaponsounds](https://github.com/DaemonAlex/dps-weaponsounds) | Custom weapon sounds (planning; no code yet). |
| [dps-events](https://github.com/DaemonAlex/dps-events) | Playtime reward events (planning; no code yet). |

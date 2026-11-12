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
| [dps-insurance](https://github.com/DaemonAlex/dps-insurance) | Ties m-Insurance into the MDT, impound, hospital and medical chart. Pairs with dps-medical. |
| [dps-studio](https://github.com/DaemonAlex/dps-studio) | Build rooms, doors and portals in game from one panel (`/studio`), with owners and managers so staff do not have to support them. |
| [dps-shops](https://github.com/DaemonAlex/dps-shops) | Shop clerks who greet and react to a robbery, then player-owned shops. |
| [dps-fleet](https://github.com/DaemonAlex/dps-fleet) | Vehicle browser and workshop on one panel: extras, liveries and mods for emergency vehicles. |
| [dps-parking](https://github.com/DaemonAlex/dps-parking) | Parking with valet, impound, violations and reserved spots. |
| [dps-vehiclepersistence](https://github.com/DaemonAlex/dps-vehiclepersistence) | Vehicles stay where they were parked. Pairs with dps-parking. |
| [dps-towjob](https://github.com/DaemonAlex/dps-towjob) | Queue-based tow job with jg-mechanic integration. |
| [dps-services](https://github.com/DaemonAlex/dps-services) | Request a tow and follow it live on the lb-phone and lb-tablet. Pairs with dps-towjob. |
| [dps-autoshops](https://github.com/DaemonAlex/dps-autoshops) | Self-service repair shops when no mechanic is on duty. |
| [dps-cityworker](https://github.com/DaemonAlex/dps-cityworker) | City infrastructure job and career. |
| [dps-ainpcs](https://github.com/DaemonAlex/dps-ainpcs) | NPCs you can talk to, with trust, quests and intel. |
| [dps-badpeds](https://github.com/DaemonAlex/dps-badpeds) | Police interaction with NPCs: stops, arrests, intel and jail records. |
| [dps-gangwars](https://github.com/DaemonAlex/dps-gangwars) | Ambient gang NPCs, territory population and war reinforcements. |
| [dps-rotations](https://github.com/DaemonAlex/dps-rotations) | Moves dealers, harvests and other spots on a fixed schedule. |
| [dps-trains](https://github.com/DaemonAlex/dps-trains) | The train system. Pairs with dps-trains-stock, dps-traintools and dps-transitapp. |
| [dps-transitapp](https://github.com/DaemonAlex/dps-transitapp) | Live train arrival boards on the lb-phone. |
| [dps-faceplant](https://github.com/DaemonAlex/dps-faceplant) | City help, reports and staff tools on the lb-phone and lb-tablet. |
| [dps-chat](https://github.com/DaemonAlex/dps-chat) | A command box for voice-only servers. No chat feed. |
| [dps-filmmode](https://github.com/DaemonAlex/dps-filmmode) | One key hides every HUD layer and gives a smooth free camera for recording. |

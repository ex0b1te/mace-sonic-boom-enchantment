#advancement revoke @s only boom:right_click
#function boom:start_boom
#item modify entity @s weapon.mainhand boom:cooldown

advancement revoke @s only boom:right_click
scoreboard objectives add boom_cd dummy

# Aktuelle Weltzeit in Ticks auslesen:
execute store result score #now boom_cd run time query gametime

# Wenn der Spieler noch nie geschossen hat, Zielwert auf 0 setzen:
execute unless score @s boom_cd matches 1.. run scoreboard players set @s boom_cd 0

# Wenn aktuelle Weltzeit >= gespeicherte Cooldown-Zeit UND mindestens 10 Level vorhanden:
execute if score #now boom_cd >= @s boom_cd if entity @s[level=10..] run function boom:start_boom
execute if score #now boom_cd >= @s boom_cd if entity @s[level=10..] run xp add @s -10 levels
execute if score #now boom_cd >= @s boom_cd if entity @s[level=10..] run scoreboard players operation @s boom_cd = #now boom_cd
execute if score #now boom_cd >= @s boom_cd if entity @s[level=10..] run scoreboard players add @s boom_cd 200

# Hinweis, wenn Level fehlen:
execute if score #now boom_cd >= @s boom_cd unless entity @s[level=10..] run title @s actionbar {"text":"Nicht genug XP! (10 Level benötigt)","color":"red"}

# Hinweis, wenn Cooldown noch läuft (mit dynamischer Restzeit-Berechnung):
scoreboard players set #twenty boom_cd 20
scoreboard players set #offset boom_cd 19
scoreboard players operation #remaining boom_cd = @s boom_cd
scoreboard players operation #remaining boom_cd -= #now boom_cd
scoreboard players operation #remaining boom_cd += #offset boom_cd
scoreboard players operation #remaining boom_cd /= #twenty boom_cd
execute if score #now boom_cd < @s boom_cd run title @s actionbar {"text":"Sonic Boom lädt noch auf! (","color":"yellow","extra":[{"score":{"name":"#remaining","objective":"boom_cd"}},{"text":"s Cooldown)","color":"yellow"}]}

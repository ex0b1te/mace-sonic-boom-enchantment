tag @s add boom_shooter
playsound minecraft:entity.warden.sonic_boom player @a ~ ~ ~ 1 1
execute anchored eyes positioned ^ ^ ^1 run function boom:raycast
tag @s remove boom_shooter
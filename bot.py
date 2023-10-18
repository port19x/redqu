import discord
from typing import Literal
from discord import app_commands
from secret import token
from redqu import redqu

waifu = discord.Client(intents=discord.Intents.default())
tree = app_commands.CommandTree(waifu)

@waifu.event
async def on_ready():
    await waifu.wait_until_ready()
    await tree.sync()
    print(f"You let me Inside as {waifu.user} UWU")

@tree.command(name='ping', description= 'latency to reach my heart')
async def ping(interaction: discord.Interaction):
        await interaction.response.send_message(f'Boing Boing UwU! (took {round(waifu.latency*1000)} ms)')

@tree.command(name='redqu', description= 'reddit media')
async def ping(interaction:discord.Interaction, sub:str,
               sort:Literal['top', 'hot', 'new', 'rising', 'controversial'] = "top",
               time:Literal['hour', 'day', 'week', 'month', 'year', 'all'] = "week",
               n:Literal['1', '2', '3', '4', '5'] = '1'):
        await interaction.response.send_message("\n".join(redqu(sub, sort, time, True, n)))

waifu.run(token)

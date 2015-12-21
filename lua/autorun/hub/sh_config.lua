RS.PDataProvider = "redactedhub_default_provider" -- don't need to change this unless you want to reset money while still storing the old amounts
RS.OpenMenuCommands = {"shop","store"}

RS.UseStock = false -- if true, you will need to manually add stock for items.

RS.HubTitle = "VHS-7 / Server Hub"
RS.Currency = "VC" -- "VaporCredits"

RS.RefundRatio = 0.5 -- percentage of cash refunded on sale

RS.InventoryLimit = 48

RS.InfoHTML = [[
	<style>

	b {
		color: #2ecc71;
	}

	body {
		max-width: 85%;
		margin-left: 24px;
	}
	</style>

	<body style="font-family: Roboto; background: #ecf0f1; color: #333;">

		<h1>Help & Commands</h1>
		<p>Welcome to the VHS-7 Server Hub. From here you can purchase cosmetics for your player using our ingame 
		currency, VC (VaporCredits). Cosmetics include items such as playermodels, hats, trails, and sound taunts. Please read 
		below for information about chat commands related to the HUB.</p>
		
		<h2>Commands</h2>
		<div style="margin-left: 24px;">

		<p>
			<b>/sendvc NAME AMOUNT</b><br>
			Send a specified amount of VC to a certain player. You cannot send more VC than you currently have.<br>
			Aliases: <b>None</b>.
		</p>
		<p>
			<b>/juke NAME AMOUNT</b><br>
			Opens the jukebox where you can play music. This can also be accessed by clicking on the Jukebox tab in the Hub.<br>
			Aliases: <b>jukebox, music</b>.
		</p>
		<p>
			<b>/shop NAME AMOUNT</b><br>
			Opens your item inventory in the Hub. Can also be accessed by pressing F3.<br>
			Aliases: <b>store, hub</b>.
		</p>

		</div>
		
		<h2>Admin Commands</h2>
		<div style="margin-left: 24px;">

		<p>
			<b>/spawnvc NAME AMOUNT</b><br>
			Spawns brand new VC for a player and adds it to their current balance.<br>
			Aliases: <b>None</b>.
		</p>
		<p>
			<b>/setvc NAME AMOUNT</b><br>
			Sets a player's VC to a specified amount.<br>
			Aliases: <b>None</b>.
		</p>
		<p>
			<b>/spawnitem NAME ITEMNAME</b><br>
			Spawns a new instance of a certain store item. ITEMNAME is the filename of the item, without the .lua extension.<br>
			Aliases: <b>None</b>.
		</p>
		<p>
			<b>/removeitems NAME ITEMNAME</b><br>
			Removes all instances of an item from a player's account. ITEMNAME is the filename of the item, without the .lua extension.<br>
			Aliases: <b>None</b>.
		</p>
		<p>
			<b>/restockempty AMOUNT</b><br>
			Restocks all empty items by a certain amount. BE CAREFUL when using this, as it takes a few seconds to go through a lot of items.<br>
			Aliases: <b>None</b>.
		</p>
		<p>
			<b>/addstorevc AMOUNT</b><br>
			Adds more VC to the store so that it's possible for players to sell their items back.<br>
			Aliases: <b>None</b>.
		</p>
		<p>
			<b>/setallstock AMOUNT</b><br>
			Sets the stock of every store item to a certain amount.<br>
			Aliases: <b>None</b>.
		</p>
		<p>
			<b>/givevip NAME</b><br>
			Gives the specified player VIP privileges.<br>
			Aliases: <b>None</b>.
		</p>
		<p>
			<b>/takevip NAME</b><br>
			Takes VIP away from the specified player.<br>
			Aliases: <b>None</b>.
		</p>
		<p>
			<b>/listvip</b><br>
			Lists all players currently online who have VIP privileges.<br>
			Aliases: <b>None</b>.
		</p>
		<p>
			<b>/checkvip NAME</b><br>
			Checks if a certain player has VIP privileges.<br>
			Aliases: <b>None</b>.
		</p>

		</div>

		<p>
		If you have any more questions regarding the Hub, feel free to ask an online staff member for help.
		</p>
		
		<h2>Credits</h2>
		<b>Arizard</b> - Development of this addon<br>
		<b>The GameREDACTED Community</b><br>
		<b>Facepunch</b>
		<br><br><br><br>

	</body>
]]
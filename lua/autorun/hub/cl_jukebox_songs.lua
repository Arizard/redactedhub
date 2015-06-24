RS.JukeSongs = {
	["Arctic Monkeys"] = {
		["Why'd You Only Call Me When You're High?"] = "https://www.youtube.com/watch?v=ivyQUekCmX8",
		["R U Mine?"] = "https://www.youtube.com/watch?v=NBqO4qlqnFE",
		["One For The Road"] = "https://www.youtube.com/watch?v=xxgFSsKkFjQ",
		["Do I Wanna Know?"] = "https://www.youtube.com/watch?v=bpOSxM0rNPM",
		["Snap Out Of It"] = "https://www.youtube.com/watch?v=PHoSRT2fNME"
	},
	["Bon Jovi"] = {
		["It's My Life"] = "https://www.youtube.com/watch?v=D7oSQ6wV5vU",
		["Livin' on a Prayer"] = "https://www.youtube.com/watch?v=9VxCFCQqI24",
	},
	["Daft Punk"] = {
		["One More Time"] = "https://www.youtube.com/watch?v=jtQC8ChpUeg",
		["Get Lucky"] = "https://www.youtube.com/watch?v=D2f6lNmmd1M"
	},
	["Red"] = {
		["Lost [Acoustic Version] (bhop_addict_v2 ending song)"] = "https://www.youtube.com/watch?v=2G7hfkGlgmc"
	},
	["Haddaway"] = {
		["What Is Love?"] = "https://www.youtube.com/watch?v=xhrBDcQq2DM",
	},
	["Taylor Swift"] = {
		["Shake It Off"] = "https://www.youtube.com/watch?v=nfWlot6h_JM"
	},
	["Duran Duran"] = {
		["Hungry Like The Wolf"] = "https://www.youtube.com/watch?v=IxW0n5Fe5CY"
	},
	["The Neighbourhood"] = {
		["Sweater Weather"] = "https://www.youtube.com/watch?v=GCdwKhTtNNw"
	},
	["Alt-J"] = {
		["Hunger of the Pine"] = "https://www.youtube.com/watch?v=dCCXq9QB-dQ",
		["Every Other Freckle"] = "https://www.youtube.com/watch?v=-mhgfXgwdls",
		["Breezeblocks"] = "https://www.youtube.com/watch?v=rVeMiVU77wo",
		["Tesselate"] = "https://www.youtube.com/watch?v=Qg6BwvDcANg",
		["Taro"] = "https://www.youtube.com/watch?v=S3fTw_D3l10",
	},
	["Queen"] = {
		["Bohemian Rhapsody"] = "https://www.youtube.com/watch?v=fJ9rUzIMcZQ",
		["I Want To Break Free"] = "https://www.youtube.com/watch?v=eM8Ss28zjcE",
		["Under Pressure"] = " https://www.youtube.com/watch?v=a01QQZyl-_I"
	},
	["Cee Lo Green"] = {
		["Forget You"] = "https://www.youtube.com/watch?v=bKxodgpyGec",

	},
	["Ed Sheeran"] = {
		["Don't"] = "https://www.youtube.com/watch?v=iD2rhdFRehU",
	},
	["Monkees"] = {
		["Daydream Believer"] = "https://www.youtube.com/watch?v=nU615FaODCg",
	},
	["Men At Work"] = {
		["Down Under"] = "https://www.youtube.com/watch?v=XfR9iY5y94s",
	},
	["Redgum"] = {
		["I Was Only 19"] = "https://www.youtube.com/watch?v=Urtiyp-G6jY"
	},
	["The Archies"] = {
		["Sugar Honey Honey"] = "https://www.youtube.com/watch?v=nwgbfriHWt8"
	},
	["INXS"] = {
		["Never Tear Us Apart"] = "https://www.youtube.com/watch?v=_VU9DjQpvMQ",
		["The One Thing"] = "https://www.youtube.com/watch?v=XJyKTNdPL5s",
		["Need You Tonight"] = "https://www.youtube.com/watch?v=w-rv2BQa2OU",
	},
	["ACDC"] = {
		["Highway To Hell"] = "https://www.youtube.com/watch?v=l482T0yNkeo",
		["Thunderstruck"] = "https://www.youtube.com/watch?v=QVBAeS5t5nc"
	},
	["The Police"] = {
		["Roxanne"] = "https://www.youtube.com/watch?v=3T1c7GkzRQQ",
		["Walking On The Moon"] = "https://www.youtube.com/watch?v=K2BlPcG74eo",
		["Message In A Bottle"] = "https://www.youtube.com/watch?v=67Qagb2Vk4Y",
	},
	["Billy Joel"] = {
		["Piano Man"] = "https://www.youtube.com/watch?v=gxEPV4kolz0",
	},
	["Elton John"] = {
		["Rocket Man"] = "https://www.youtube.com/watch?v=-LX7WrHCaUA",
		["Can You Feel The Love Tonight? [The Lion King]"] = "https://www.youtube.com/watch?v=25QyCxVkXwQ",
		["Can You Feel The Love Tonight?"] = "https://www.youtube.com/watch?v=fTtgVSxfr5M"
	},
	["Jimmy Barnes"] = {
		["Working Class Man"] = "https://www.youtube.com/watch?v=erSJGrpfnOI"
	},
	["Led Zeppelin"] = {
		["Stairway To Heaven"] = "https://www.youtube.com/watch?v=BcL---4xQYA"
	},
	["Andrew Gold"] = {
		["Spooky Scary Skeletons"] = "https://www.youtube.com/watch?v=K2rwxs1gH9w"
	},
	["Kansas"] = {
		["Carry On Wayward Son"] = "https://www.youtube.com/watch?v=2X_2IdybTV0"
	},
	["Darude"] = {
		["Sandstorm"] = "https://www.youtube.com/watch?v=y6120QOlsfU"
	},
	["Daler Mehndi"] = {
		["Tunak Tunak Tun"] = "https://www.youtube.com/watch?v=vTIIMJ9tUc8"
	},
	["RUN DMC"] = {
		["It's Tricky"] = "https://www.youtube.com/watch?v=1cYQV62WhkM"
	},
	["Bloodhound Gang"] = {
		["The Bad Touch"] = "https://www.youtube.com/watch?v=xat1GVnl8-k"
	}
}

--print( util.TableToJSON( RS.JukeSongs ) )



http.Fetch( "http://gameredacted.net/jukebox_songs.lua",

	function( body, len, headers, code )
		local luatorun = body

		luatorun = [[tempsongs = ]]..luatorun

		RunString( luatorun )

		print( luatorun, tempsongs )

		if tempsongs == nil then tempsongs = {} end

		for artist, song in pairs(tempsongs) do
			RS.JukeSongs[artist] = {}
			for sname, slink in pairs( song ) do
				RS.JukeSongs[artist][sname] = slink
			end
		end

		PrintTable( RS.JukeSongs )
	end,

	function( error )

	end
)
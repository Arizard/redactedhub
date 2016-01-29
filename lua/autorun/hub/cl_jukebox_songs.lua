RS.JukeSongs = {}

-- this retrieves it from the list of things on the website so that the servers have more than one thing ya feel?
http.Fetch( "https://raw.githubusercontent.com/Arizard/redactedhub/master/jukebox_songs.lua",

	function( body, len, headers, code )
		local luatorun = body

		RunString( luatorun ) -- SPOOKY RUNSTRING!!!!!!!

		--print( luatorun, tempsongs )

		if tempsongs == nil then tempsongs = {} end

		for artist, song in pairs(tempsongs) do
			RS.JukeSongs[artist] = {}
			for sname, slink in pairs( song ) do
				RS.JukeSongs[artist][sname] = slink
			end
		end

		--PrintTable( RS.JukeSongs )

		if tempstreams == nil then tempstreams = {} end

		RS.JukeStreams = table.Copy( tempstreams )
	end,

	function( error )

	end
)
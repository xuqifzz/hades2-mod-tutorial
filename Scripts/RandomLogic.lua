local Rng = { id = -1 }

function Rng:New(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Rng:Seed(s, id)
	local debugRngSeed = GetConfigOptionValue({ Name = "DebugRNGSeed" })
	if debugRngSeed ~= 0 then
		s = debugRngSeed
	end
	self.seed = s
	self.id = id or self.id
	self.id = randomseed(s, self.id)
end

function Rng:Random( a, b )
	if a and b then
		return randomint(a, b, self.id)
	elseif a then
		return randomint(1, a, self.id)
	else
		return random( self.id )
	end
end

function Rng:RandomGaussian()
	return randomgaussian( self.id )
end

function GetClockSeed()
	return math.floor( GetTime({}) * 1000000 )
end

local Randoms =
{
	[1] = Rng:New()
}
Randoms[1]:Seed( GetClockSeed(), 1 )

function GetGlobalRng()
	return Randoms[1]
end

NextSeeds = NextSeeds or {}

function RandomInit( rngId )

	rngId = rngId or 1
	if Randoms[rngId] == nil then
		Randoms[rngId] = Rng:New()
	end
	if NextSeeds[rngId] == nil then
		NextSeeds[rngId] = GetClockSeed()
	end

	Randoms[rngId]:Seed( NextSeeds[rngId], rngId )
	--DebugPrint({ Text = "RandomInit("..rngId..") with seed: "..Randoms[rngId].seed }) -- Display real seed used if DebugRNGSeed enabled

	return Randoms[rngId]
end

function RandomSynchronize( offset, rngId )
	-- Use this for determinism, without always having to restart the rng sequence to 0
	if rngId == nil then
		rngId = 1
	end
	if offset == nil then
		offset = 0
	end
	local rng = RandomInit( rngId )
	while offset > 0 do
		offset = offset - 1
		CoinFlip(rng)
	end
end

function RandomSetNextInitSeed( args )
	-- On the next map load, RandomInit will use the given seed.
	-- Pairs well with SaveCheckpoint({...})
	local rngId = 1
	local seed = RandomInt(-2147483647, 2147483646)

	if args ~= nil then
		if args.Id ~= nil then
			rngId = args.Id
		end
		if args.Seed ~= nil then
			seed = args.Seed
		end
	end

	NextSeeds[rngId] = seed
end

function RandomInt( low, high, rng )

	local rng = rng or GetGlobalRng()
	local randomInt = rng:Random( low, high )
	return randomInt

end

function RandomFloat( low, high, rng )

	local rng = rng or GetGlobalRng()
	local randomFloat = low + ( rng:Random() * (high - low) )
	return randomFloat

end

function RandomNumber( number, rng )
	local rng = rng or GetGlobalRng()
	return rng:Random( number )
end

function RandomChance( chance, rng )
	if chance == nil then
		return false
	end
	local rng = rng or GetGlobalRng()
	return rng:Random() <= chance
end

function CoinFlip( rng )

	local rng = rng or GetGlobalRng()
	return rng:Random() > 0.5

end

function RandomNormal( mean, stddev, rng )

	local rng = rng or GetGlobalRng()
	return mean + rng:RandomGaussian() * stddev;

end
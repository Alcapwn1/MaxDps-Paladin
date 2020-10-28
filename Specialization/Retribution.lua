local _, addonTable = ...;

--- @type MaxDps
if not MaxDps then return end

local Paladin = addonTable.Paladin;
local MaxDps = MaxDps;
local UnitPower = UnitPower;
local HolyPower = Enum.PowerType.HolyPower;
local RT = {
	TalentSelflessHealer	= 114250,
	--AuraDivinePurpose =
	AuraJudgment			= 197277,
	TalentRighteousVerdict  = 267610,
	TalentEmpyreanPower     = 286393,
}
_,_,_,_,_,_,RT.Judgment = GetSpellInfo("Judgment");
_,_,_,_,_,_,RT.Consecration = GetSpellInfo("Consecration");
_,_,_,_,_,_,RT.Rebuke = GetSpellInfo("Rebuke");
_,_,_,_,_,_,RT.ShieldOfVengeance = GetSpellInfo("Shield Of Vengeance");
_,_,_,_,_,_,RT.AvengingWrath = GetSpellInfo("Avenging Wrath");
_,_,_,_,_,_,RT.Crusade = GetSpellInfo("Crusade");
_,_,_,_,_,_,RT.TemplarsVerdict = GetSpellInfo("Templar's Verdict");
_,_,_,_,_,_,RT.ExecutionSentence = GetSpellInfo("Execution Sentence");
_,_,_,_,_,_,RT.DivineStorm = GetSpellInfo("Divine Storm");
_,_,_,_,_,_,RT.HammerOfWrath = GetSpellInfo("Hammer Of Wrath");
_,_,_,_,_,_,RT.BladeOfJustice = GetSpellInfo("Blade Of Justice");
_,_,_,_,_,_,RT.CrusaderStrike = GetSpellInfo("Crusader Strike");
_,_,_,_,_,_,RT.FlashOfLight = GetSpellInfo("Flash Of Light");
_,_,_,_,_,_,RT.WakeOfAshes = GetSpellInfo("Wake Of Ashes");

local A = {
	DivineRight = 277678
}

setmetatable(A, Paladin.spellMeta);
setmetatable(RT, Paladin.spellMeta);

function Paladin:Retribution()
	local fd = MaxDps.FrameData;
	fd.targets = MaxDps:SmartAoe();
	local holyPower = UnitPower('player', HolyPower);
	fd.holyPower = holyPower;
	local cooldown = fd.cooldown;
	local buff = fd.buff;
	local debuff = fd.debuff;
	local talents = fd.talents;
	local targets = fd.targets;
	local gcd = fd.gcd;
	local holyPower = fd.holyPower;
	local targetHp = MaxDps:TargetPercentHealth() * 100;
	local health = UnitHealth('player');
	local healthMax = UnitHealthMax('player');
	local healthPercent = ( health / healthMax ) * 100;
	
	
	if talents[RT.TalentSelflessHealer] and healthPercent < 90 and buff[BR.SelflessHealer].count > 3 then
		return FlashOfLight;
	end
	if holyPower >= 3 and targets <= 2 then
		return RT.TemplarsVerdict;
	end
	if holyPower >= 3 and targets >= 3 then
		return RT.DivineStorm;
	end
	if cooldown[RT.WakeOfAshes].ready then
		return RT.WakeOfAshes;
	end
	if cooldown[RT.BladeOfJustice].ready then
		return RT.BladeOfJustice;
	end
	if targetHp <= 20 and cooldown[RT.HammerOfWrath].ready then
		return RT.HammerOfWrath;
	end
	if cooldown[RT.Judgment].ready then
		return RT.Judgment;
	end
	if cooldown[RT.CrusaderStrike].ready then
		return RT.CrusaderStrike;
	end
	if cooldown[RT.Consecration].ready then
		return RT.Consecration;
	end
end
--/run name, rank, icon, castTime, minRange, maxRange, spellID = GetSpellInfo("Shadowbolt");print(spellID);
--/run test = select(7, (GetSpellInfo("Consecration")));print(test);

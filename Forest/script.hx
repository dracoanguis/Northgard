// --- Saved variables ---
// You can add what you want to the save
wildBoars = [0];
killedWolves = 0;
wolfDen = 0;

function saveState() {
	state.scriptProps = {
		wildBoars 		: wildBoars,
		killedWolves	: killedWolves,
		wolfDen 		: wolfDen,
	};
}


// --- Local variables ---
var wolfpack = [];

// --- Flags ---
var summonedWolves = false;

// --- functions ---

function setVictory(){
	state.removeVictory(VictoryKind.VMilitary);
	state.removeVictory(VictoryKind.VFame);
	state.removeVictory(VictoryKind.VMoney);
	state.removeVictory(VictoryKind.VLore);
}

function createWolves(id:Int,nbr:Int){
	var place = getZone(id);
	var wolves = place.addUnit(Unit.Wolf,nbr);
	return wolves;
}

function createDen(id:Int){
	var denZone = getZone(id);
	denZone.createBuilding(Building.WolvesCave,true);
	denZone.addUnit(Unit.Wolf,9);
	denZone.addUnit(Unit.SacredWolf,1);
}

// --- Script code ---
function init() {
	if (state.time == 0)
		onFirstLaunch();
	onEachLaunch();
}

function onFirstLaunch() {
	// Select boars placement
	var boarZones = [59,51,71,80,86,72,64,55,32,49,56,62,61,78,90,95,83,87,66];
	while (wildBoars.length < 10) {
		var rng = randomInt(boarZones.length);
		if (!wildBoars.contains(boarZones[rng]))
			wildBoars.push(boarZones[rng]);
	}

	// create boars
	for (i in 0...wildBoars.length){
		var crZone = getZone(wildBoars[i]);
		crZone.addUnit(Unit.GiantBoar,1,me());
		me().takeControl(crZone);
	}

	// create wolf den
	do {
		var rng = randomInt(boarZones.length);
		wolfDen = boarZones[rng];
		createDen(wolfDen);
	} while (!wildBoars.contains(wolfden))


	// set objective
	state.objectives.add("killWolvesId","Nettoyez la forets des envahiseurs: tuer 100 loups", {showProgressBar:true, visible:true, goalVal:100, autoCheck:true});

	// set victory
	setVictory();

}

function onEachLaunch() {

}

// Regular update is called every 0.5s
function regularUpdate(dt : Float) {
	if (toInt(state.time) > 10 && !summonedWolves){
		summonedWolves = true;
		var rng = randomInt(10);
		wolfpack = createWolves(wildBoars[rng],10);

	}
}
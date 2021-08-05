--Truck
Config	=	{}

 -- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 35000

-- Default weight for an item:
	-- weight == 0 : The item do not affect character inventory weight
	-- weight > 0 : The item cost place on inventory
	-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 10



-- If true, ignore rest of file
Config.WeightSqlBased = false

-- I Prefer to edit weight on the config.lua and I have switched Config.WeightSqlBased to false:

Config.localWeight = {
	--BOISSONS--

	water = 100, --Eau
	vodka = 100, --Vodka
	tequila = 100, --Tequilala
	beer = 100, --Bierre 86
	whisky = 100, --Whisky
	mojito = 100, --Mojito
	soda = 200, --Soda
	cocktail = 200, --Cocktail de fruits
	rhum = 200, --Rhum
	coca = 100, --Cola
	sprite = 200, --Sprite
	pepsi = 200, --Pepsi
	coffee = 200, --Café
	orangejus = 500,-- Jus d'Orange
	orange_pooch = 500, --Jus d'Orange
	coca = 200, --Coca
	pomme_pooch = 500, --Jus de pomme
	energy = 200, --Energy Drink


	--NOURRITURES--

	bread = 100, --Pain
	chocolate = 200, --Barre Chocolatn
	viande = 300, --Viande
	frites = 300, --Frites
	orange = 250, --Orange
	pomme = 200, --Fruit
	mkebab = 500, --Kebab


	--OBJETS--

	radio = 2000, --Radio talki Walki
	coffre = 250, --Coffre top serveur
	gazbottle = 2000, --Bouteille de Gaz
	fixtool = 1000, --Outil de reparation (marche pas)
	carotool = 1000, --Outil carosserie (marche pas)
	blowpipe = 300, --Chalumaux
	fixkit = 1400, --Kit de reparation
	carokit = 1400, --Kit de carosserie
	defibrilateur = 1000, --Defibrillateur
	medkit = 800, --Met kit
	bandage = 300, --Bandage
	silent = 600, --Silencieux
	gps = 100, --GPS
	phone = 100, --TELEPHONE PHONE
	bullet1 = 800, --Gillet par Balle 1
	bullet2 = 1000, --Gillet par Balle 2
	bullet3 = 1500, --Gillet par Balle 3
	bullet4 = 2000, --Gillet par Balle 4
	hazmat1 = 800, --Tenue Azmat Noir
	hazmat2 = 810, --Tenue Azmat Bleu
	hazmat3 = 810, --Tenue Azmat Jaune
	hazmat4 = 810, --Tenue Azmat Blanche
	cigaret = 200, --Cigarette
	tresor = 2000, --Tresor
	clip = 800, --Chargeur
	fishing_rod = 1000, --Canne a peche
	cagoule = 500, --Cagoule
	ball = 300, --Ballon
	bong = 300, --Bang (pipe a eau) a utiliser avec weed
	notepad = 200, --Cahier de note
	parapluie = 500, --Parapluie
	jumelles = 1000, --Jumelles
	cryptedphone = 100, --Telephone Crypter
	plastique = 100,


	--ITEMS--
	
	weed = 200, --Weed
	weed_pooch = 500, --Pochon de Weed
	coke = 200, --Coke
	coke_pooch = 500, --Pochon de Coke
	meth = 200, --Meth
	meth_pooch = 500, --Pochon de Meth
	rose = 100, --Rose
	doliprane = 100, --Doliprane
	kondom = 100, --Preservatif
	baque = 100, --Alliance
	gratte = 100, --Ticket loto
	contract = 100, -- Acte de vente
	coyotte = 400, --Coyote
	lighter = 100, --Briquet
	drill = 15000, --Marteau piqueur
	pelle = 2000, --Pelle
	truele = 800, --truelle
	pharma3 = 300, --Weed medicinale
	acetone = 200, --Acetone
	billet_pooch = 500, -- Billet faux
	billet = 200, -- billets
    lithium = 100, --Lithium
	methlab = 100, --Methlab
	madera = 1000, -- Goyave
	maderag = 1000, -- Épicéa
	maderam = 1000, -- Cèdre
	maderaf = 1000, -- Pin
	ephedrine = 10,
	patecoca = 10,
	feuillecoca = 4,

	--JOBS--

    --Brasseur
	orge = 100, --Orge pour Brasseur

    --Abbateur
	alive_chicken = 100, --Poulet vivant
	slaughtered_chicken = 100, --Poulet abbatut
	packaged_chicken = 100, --Poulet en Barquette

	--Mineur
	stone = 400, --Pierre pour farm job
	washed_stone = 40, --Pierre lavee
	stone_pooch = 200, --Fer pour farm job

	copper = 3, --Cuivre
	cuir = 300, --CUIR
	cuir_pooch = 400, --CUIR
	cuivre_pooch = 400, --CUIR

	iron = 1000, --Metal Fer
	gold = 5, --Or
	diamond = 8, --Diamend

	--Bucherons
	wood = 500, --Bois pour farm job
	bois = 200, --Bois pour farm job
	wood_pooch = 300, --PLanche de bois
	bois_pooch = 600, --PLanche de bois
	cutted_wood = 700, --Bois couper
	packaged_plank = 500, --Paquet de planche
	hacha = 1000, -- hache
	maderacaoba = 600,
	maderanogal = 600,
	maderaroble = 600,

	--Vitrier
	sand_pooch = 1000, --Verre
	sable_pooch = 1000, --Verre
	sand = 500, --Sable
	sable = 500, --Sable

	--Couturier
	fabric = 300, --Tissu
	clothe = 600, --Vetement

	--Restauration
	menthe = 100, --Menthe
	patate = 800, --Patate
	phos_pooch = 800, --Phosphore

	--Tabac
	tabacblond = 300, --Tabac
	tabacbrun = 300, --Tabac
	tabacblondsec = 300, --Tabac
	tabacbrunsec = 300, --Tabac

	--Raffineur
	fuel = 500, --Petrol
	fuel_pooch = 1000, --Petrol traiter
	petrol = 1000, --Petrol traiter
	petrol_raffin = 1000, --Petrol raffiner
	essence = 1000, --Petrol  essence

	--ARME WEASPON--

	WEAPON_KNIFE = 300, --Couteau normal
	WEAPON_KNUCKLE = 200, --Poing americain
	WEAPON_NIGHTSTICK = 500, --Mattraque
	WEAPON_HAMMER = 700, --Marteau
	WEAPON_BAT = 800, --Bat de baseball
	WEAPON_GOLFCLUB = 600, --Bat de Golf
	WEAPON_CROWBAR = 5000, --Pied de biche
	WEAPON_BOTTLE = 300, --Bouteille cassé
	WEAPON_DAGGER = 800, --Couteau Dagger
	WEAPON_HATCHET = 1000, --Hachette bois
	WEAPON_MACHETE = 700, --Machette
	WEAPON_FLASHLIGHT = 600, --Lampe torche
	WEAPON_SWITCHBLADE = 500, --Couteau papillon
	WEAPON_BZGAS = 1000, --Gaz
	WEAPON_SMOKEGRENADE = 200, --Smoke 
	WEAPON_MOLOTOV = 600, --Cocktel Molotov
	WEAPON_FIREEXTINGUISHER = 3200, --Extincteur
	WEAPON_PETROLCAN = 2000, --Bidon d'essence
	WEAPON_FLARE = 800, --Fusée eclairante
	WEAPON_BALL = 300, --Petite ball
	WEAPON_REVOLVER = 2700, --Revolver
	WEAPON_POOLCUE = 300, --Barre de Billard
	WEAPON_PIPEWRENCH = 1100, --Clef a molette
	WEAPON_PISTOL = 1100, --Pistolet 
	WEAPON_COMBATPISTOL = 1000, --Pitolet Combat
	WEAPON_PISTOL50 = 3100, --Desert eaglel
	WEAPON_SNSPISTOL = 800, --Petoire
	WEAPON_HEAVYPISTOL = 1200, --Pistolet viseur
	WEAPON_VINTAGEPISTOL = 1300, --Pistolet Vintage
	WEAPON_STUNGUN = 600, --Taser
	WEAPON_FLAREGUN = 900, --Fusee de detresse
	WEAPON_MARKSMANPISTOL = 2800, --Pistol fusil court
	WEAPON_MICROSMG = 2400, --UZI
	WEAPON_MINISMG = 1600, --Scorpion
	WEAPON_SMG = 3100, --SMG MP5
	WEAPON_ASSAULTSMG = 2800, --P90
	WEAPON_MG = 14000, --MG bateuse
	WEAPON_COMBATMG = 15000, --MG combat
	WEAPON_COMBATPDW = 3860, --SMG PDW
	WEAPON_GUSENBERG = 7800, --Mitrailleuse Camembere Gangster
	WEAPON_MACHINEPISTOL = 2400, --Pistolet mitrailleur leger
	WEAPON_ASSAULTRIFLE = 8000, --AK 47
	WEAPON_CARBINERIFLE = 8000, --Carabine Assault
	WEAPON_ADVANCEDRIFLE = 8000, --Advanced assault
	WEAPON_SPECIALCARBINE = 8000, --G36
	WEAPON_BULLPUPRIFLE = 8000, --Assault BullUp
	WEAPON_COMPACTRIFLE = 6200, --Mini AK47U
	WEAPON_PUMPSHOTGUN = 4200, --Fusil a pompe
	WEAPON_SAWNOFFSHOTGUN = 3600, --Pompe Canon scier
	WEAPON_MUSKET = 4500, --Musket de chasse
	WEAPON_DBSHOTGUN = 3000, --Pompe double canon/coup
	WEAPON_SNIPERRIFLE = 16000, --Sniper Rifle
	WEAPON_HEAVYSNIPER = 18000, --Sniper barrett
	WEAPON_DOUBLEACTION = 2600, --revolver Red Dead
	yusuf = 300, --Skin arme
	grip = 300, --Poigner arme
	flashlight = 300, --Lampe arme

	--ITEM INVALID--		

	nitro = 300, --item Invalid		
	weaponcard = 300, --item Invalid
	tel_cargo = 50, --item Invalid
	doliprane_cargo = 50, --item Invalid
	weed_seed = 300, --item Invalid
	muriatic_acide = 300, --item Invalid
	hydrogene_clauride = 300, --item Invalid
	caustic_soda = 300, --item Invalid
	spark = 300, --item Invalid
	tesla = 300, --item Invalid
	formol = 300, --item Invalid
	alcool_cargo = 300, --item Invalid
	vodkrb = 300, --item Invalid
	whiskycoc = 300, --item Invalid
	myrte = 300, --item Invalid
	alcool = 300, --item Invalid
	myrtealcool = 300, --item Invalid
	redbull = 300, --item Invalid
	clip_50 = 300, --item Invalid
	gun_part = 300, --item Invalid
	metal = 300, --item Invalid
	coal = 300, --item Invalid
	sulfur = 300, --item Invalid
	weaponcard = 300, --item Invalid
	redbull_cargo = 300, --item Invalid
	cigaret_cargo = 300, --item Invalid
	beer_cargo = 300, --item Invalid
	water_cargo = 300, --item Invalid
	bread_cargo = 300, --item Invalid
	cocacola_cargo = 300, --item Invalid
	myrte_cargo = 300, --item Invalid
	agrume = 300, --item Invalid
	cafeine = 300, --item Invalid
	cacao = 300, --item Invalid
	cerealesmaltees = 300, --item Invalid
	feuilledecoca = 300, --item Invalid
	thefroid = 300, --item Invalid
	sirop = 300, --item Invalid
	fisher = 300, --item Invalid
	hunt = 300, --item Invalid
	coffee_cargo = 300, --item Invalid
	meat = 300, --item Invalid
	whool = 100, --item invalide
	drive = 300, --Item invalide
	dmv = 110, --Item invalide
	grapesjus = 300, --item Invalid
	grape = 300, --item Invalid
	swim = 300, --item Invalid
	malbora = 300, --Item invalid
	gitanes = 300, --Item invalid
	dopamine = 300, --Item invalid
	adrenaline = 300, --Item invalid
	splif = 300, --Splif de weed
	formol = 300, --Item invalid
	puce = 300, --Item invalid
	tracker = 300, --Item invalid
	sniffer = 300, --Item invalid
	lightbreak = 300, --Item invalid
	amoniac = 300, --Item invalid
	phosphorerouge = 300, --Item invalid
	iode = 300, --Item invalid
	houblon = 300, --Item invalid
	malte = 300, --Item invalid
	sucre = 300, --Item invalid
	fruits = 300, --Item invalid
	sedatif = 300, --Item invalid
	bague = 300, --Item invalid
	fiancaille = 300, --Item invalid
	journal = 300, --Item invalid
}

Config.VehicleLimit = {
    [0]=45000, -- Compacts
    [1]=55000, -- Sedans
    [2]=80000, -- SUVs
    [3]=50000, -- Coupes
    [4]=40000, -- Muscle
    [5]=35000, -- Sports Classics
    [6]=30000, -- Sports
    [7]=20000, -- Super
    [8]=5000, -- Motorcycles
    [9]=80000, -- Off-road
    [10]=90000, -- Industrial
    [11]=20000, -- Utility
    [12]=85000, -- Vans
    [13]=0, -- Cycles
    [14]=115000, -- Boats
    [15]=95000, -- Helicopters
    [16]=100000, -- Planes
    [17]=70000, -- Service
    [18]=60000, -- Emergency
    [19]=105000, -- Military
    [20]=120000, -- Commercial
}

Config.VehiclePlate = {
    taxi = "TAXI",
    cop = "LSPD",
    ambulance = "EMS",
    mecano = "MECA"
}

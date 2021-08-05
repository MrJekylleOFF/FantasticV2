Config = {}
Config.Locale = 'fr'

Config.DoorList = {
	{
		textCoords = vector3(434.7, -982.0, 31.5),
		authorizedJobs = {'police'},
		locked = false,
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('v_ilev_ph_door01'), objHeading = 270.0, objCoords = vector3(434.7, -980.6, 30.8)},
			{objHash = GetHashKey('v_ilev_ph_door002'), objHeading = 270.0, objCoords = vector3(434.7, -983.2, 30.8)}
		}
	},
	{
		textCoords = vector3(3531.76, 3670.20, 28.12),
		authorizedJobs = {'nightclub'},
		locked = true,
		maxDistance = 5,
		doors = {
			{objHash = GetHashKey('v_ilev_bl_doorsl_r'),  objCoords = vector3(3531.02, 3670.45, 28.12)},
			{objHash = GetHashKey('v_ilev_bl_doorsl_l'),  objCoords = vector3(3532.46, 3670.12, 28.12)}
		}
	},
	{
		textCoords = vector3(3532.16, 3664.63, 28.12),
		authorizedJobs = {'nightclub'},
		locked = true,
		maxDistance = 5,
		doors = {
			{objHash = GetHashKey('v_ilev_bl_doorsl_l'),  objCoords = vector3(3532.89, 3665.29, 28.12)},
			{objHash = GetHashKey('v_ilev_bl_doorsl_r'),  objCoords = vector3(3532.69, 3663.97, 28.12)}
		}
	},
	{
		objHash = GetHashKey('v_ilev_ml_door1'),
		objHeading = 160.0,
		objCoords  = vector3(232.61, 365.64, 106.13),
		textCoords = vector3(232.61, 365.64, 106.13),
		authorizedJobs = { 'autoecole' },
		locked = true,
		maxDistance = 5
	},
	{
		objHash = GetHashKey('v_ilev_rc_door2'),
		objHeading = 90.0,
		objCoords  = vector3(424.41, -995.12, 22.66),
		textCoords = vector3(424.41, -995.12, 22.66),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 5
	},
	{
		objHash = GetHashKey('v_ilev_rc_door2'),
		objHeading = 90.0,
		objCoords  = vector3(424.41, -1005.12, 22.66),
		textCoords = vector3(424.41, -1005.24, 22.66),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 5
	},
	{
		objHash = GetHashKey('v_ilev_gtdoor'),
		objHeading = 0.0,
		objCoords  = vector3(431.32, -978.12, 22.66),
		textCoords = vector3(431.41, -978.24, 22.66),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 5
	},
	{
		objHash = GetHashKey('v_ilev_gtdoor'),
		objHeading = 0.0,
		objCoords  = vector3(425.32, -978.12, 22.66),
		textCoords = vector3(425.41, -978.24, 22.66),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 5
	},
	{
		objHash = GetHashKey('v_ilev_gtdoor'),
		objHeading = 0.0,
		objCoords  = vector3(419.32, -978.12, 22.66),
		textCoords = vector3(419.41, -978.24, 22.66),
		authorizedJobs = { 'police' },
		locked = true,
		maxDistance = 5
	},
	{
		textCoords = vector3(424.2, -1000.38, 22.66),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('v_ilev_rc_door2'), objHeading = -90.0, objCoords = vector3(424.28, -999.81, 22.66)},
			{objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 90.0, objCoords = vector3(424.59, -1000.91, 22.66)},
		}
	},
	{
		textCoords = vector3(327.7, -593.95, 43.28),
		authorizedJobs = {'ambulance'},
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('gabz_pillbox_doubledoor_l'), objHeading = -110.0, objCoords = vector3(327.51, -593.24, 43.28)},
			{objHash = GetHashKey('gabz_pillbox_doubledoor_r'), objHeading = -110.0, objCoords = vector3(327.05, -594.47, 43.28)}
		}
	},
	{
		textCoords = vector3(325.36, -589.7, 43.28),
		authorizedJobs = {'ambulance'},
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('gabz_pillbox_doubledoor_l'), objHeading = -20.0, objCoords = vector3(324.80, -589.91, 43.28)},
			{objHash = GetHashKey('gabz_pillbox_doubledoor_r'), objHeading = -20.0, objCoords = vector3(325.9, -590.15, 43.28)}
		}
	},
	{
		textCoords = vector3(325.98, -579.27, 43.28),
		authorizedJobs = {'ambulance'},
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('gabz_pillbox_doubledoor_l'), objHeading = -110.0, objCoords = vector3(327.23, -578.8, 43.28)},
			{objHash = GetHashKey('gabz_pillbox_doubledoor_r'), objHeading = -110.0, objCoords = vector3(325.51, -579.6, 43.28)}
		}
	},
	{
		textCoords = vector3(-419.83, 267.96, 83.2),
		authorizedJobs = {'comedy'},
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('comedy_door'),  objCoords = vector3(-419.5, 267.8, 83.2)},
			{objHash = GetHashKey('comedy_door'),  objCoords = vector3(-420.2, 267.97, 83.2)}
		}
	},
	{
		textCoords = vector3(-432.96, 267.79, 83.42),
		authorizedJobs = {'comedy'},
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('comedy_door'),  objCoords = vector3(-432.33, 268.2, 83.43)},
			{objHash = GetHashKey('comedy_door'),  objCoords = vector3(-432.82, 267.47, 83.43)}
		}
	},
	{
		textCoords = vector3(-430.02, 262.17, 83.0),
		authorizedJobs = {'comedy'},
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('comedy_door'),  objCoords = vector3(-429.63, 262.19, 83.01)},
			{objHash = GetHashKey('comedy_door'),  objCoords = vector3(-430.4, 262.33, 83.01)}
		}
	},
	{
		objHash = GetHashKey('comedy_door'),
		objCoords  = vector3(-424.31, 271.43, 83.42),
		textCoords  = vector3(-424.25, 271.94, 83.44),
		authorizedJobs = { 'comedy' },
		locked = true,
		maxDistance = 2.5
	},
	{
		objHash = GetHashKey('comedy_door'),
		objCoords  = vector3(-453.01, 279.05, 83.64),
		textCoords  = vector3(-453.06, 279.0, 83.94),
		authorizedJobs = { 'comedy' },
		locked = true,
		maxDistance = 2.5
	},

	--villa play boys
	{
		objHash = GetHashKey('v_ilev_mm_door'),
		objHeading = -135.0,
		objCoords  = vector3(-1501.06, 103.48, 55.6),
		textCoords = vector3(-1501.0, 103.34, 55.6),
		authorizedJobs = { 'nightclub' },
		locked = true,
		maxDistance = 5
	},
	{
		objHash = GetHashKey('v_ilev_mm_door'),
		objHeading = -40.0,
		objCoords  = vector3(-1522.46, 143.2, 55.6),
		textCoords = vector3(-1522.46, 143.2, 55.6),
		authorizedJobs = { 'nightclub' },
		locked = true,
		maxDistance = 5
	},
	{
		objHash = GetHashKey('prop_doormaf'),
		objHeading = 135.0,
		objCoords  = vector3(-1536.84, 131.35, 57.3),
		textCoords = vector3(-1536.48, 131.34, 57.3),
		authorizedJobs = { 'nightclub' },
		locked = true,
		maxDistance = 5
	},

	--hopital
	{
		objHash = GetHashKey('gabz_pillbox_singledoor'),
		objHeading = -110.0,
		objCoords  = vector3(313.44, -596.4, 43.3),
		textCoords = vector3(313.0, -596.4, 43.3),
		authorizedJobs = { 'ambulance' },
		locked = true,
		maxDistance = 5
	},
	{
		objHash = GetHashKey('v_ilev_fh_frontdoor'),
		objHeading = -210.0,
		objCoords  = vector3(8.33, 539.12, 176.03),
		textCoords = vector3(8.33, 539.12, 176.09),
		authorizedJobs = { 'smithfamily' },
		locked = true,
		maxDistance = 5
	},
	{
		objHash = GetHashKey('v_ilev_fh_frntdoor'),
		objHeading = 226.0,
		objCoords  = vector3(2435.79, 4975.67, 46.57),
		textCoords = vector3(2435.79, 4975.67, 46.57),
		authorizedJobs = { 'dsmafia' },
		locked = true,
		maxDistance = 5
	},
	{
		objHash = GetHashKey('v_ilev_fh_frntdoor'),
		objHeading = 316.0,
		objCoords  = vector3(2440.23, 4982.67, 46.57),
		textCoords = vector3(2440.10, 4982.67, 46.57),
		authorizedJobs = { 'dsmafia' },
		locked = true,
		maxDistance = 5
	},
	{
		objHash = GetHashKey('v_ilev_fh_frntdoor'),
		objHeading = 225.0,
		objCoords  = vector3(2449.23, 4989.67, 46.57),
		textCoords = vector3(2449.10, 4989.67, 46.57),
		authorizedJobs = { 'dsmafia' },
		locked = true,
		maxDistance = 5
	},
	{
		objHash = GetHashKey('v_ilev_fh_frntdoor'),
		objHeading = 316.0,
		objCoords  = vector3(2452.50, 4969.67, 46.57),
		textCoords = vector3(2452.50, 4969.67, 46.57),
		authorizedJobs = { 'dsmafia' },
		locked = true,
		maxDistance = 5
	},
	-- Entrance mechanic
	{
		objHash = GetHashKey('lr_prop_supermod_door_01'),
		objCoords  = vector3(-205.614, -1310.67, 31.29),
		textCoords = vector3(-205.614, -1310.67, 32.29),
		authorizedJobs = { 'mechanic' },
		locked = false,
		maxDistance = 14
	},
	-- To locker room & roof
	{
		objHash = GetHashKey('v_ilev_ph_gendoor004'),
		objHeading = 90.0,
		objCoords = vector3(449.6, -986.4, 30.6),
		textCoords = vector3(450.1, -986.3, 31.7),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},

	-- LOCO SHERIFF LIAM DASILVA
	{
		objHash = GetHashKey('v_ilev_gc_door01'),
		objHeading = -45.0,
		objCoords = vector3(-451.8, 6006.041, 31.8),
		textCoords = vector3(-451.8, 6006.041, 31.8),
		authorizedJobs = {'inspecteur'},
		locked = true,
		maxDistance = 2.00
	},
	{
		objHash = GetHashKey('v_ilev_gc_door01'),
		objHeading = 135.0,
		objCoords = vector3(-447.142, 6001.337, 31.6),
		textCoords = vector3(-447.142, 6001.337, 31.6),
		authorizedJobs = {'inspecteur'},
		locked = true,
		maxDistance = 2.00
	},
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 315.0,
		objCoords = vector3(-432.022, 5999.756, 31.716),
		textCoords = vector3(-432.022, 5999.756, 31.716),
		authorizedJobs = {'inspecteur'},
		locked = true,
		maxDistance = 2.00
	},
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 315.0,
		objCoords = vector3(-429.039, 5996.502, 31.716),
		textCoords = vector3(-429.039, 5996.502, 31.716),
		authorizedJobs = {'inspecteur'},
		locked = true,
		maxDistance = 2.00
	},
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 315.0,
		objCoords = vector3(-432.9, 5992.09, 31.7),
		textCoords = vector3(-432.9, 5992.09, 31.7),
		authorizedJobs = {'inspecteur'},
		locked = true,
		maxDistance = 2.00
	},
	{
		textCoords = vector3(-444.05, 6015.65, 31.71),
		authorizedJobs = {'inspecteur'},
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('v_ilev_shrf2door'), objHeading = 135.0, objCoords = vector3(-444.4, 6016.2, 31.7)},
			{objHash = GetHashKey('v_ilev_shrf2door'), objHeading = 315.0, objCoords = vector3(-443.5, 6015.2, 31.7)}
		}
	},
	{
		objHash = GetHashKey('v_ilev_rc_door2'),
		objHeading = 135.0,
		objCoords = vector3(-449.8, 6016.3, 31.7),
		textCoords = vector3(-449.8, 6016.3, 31.7),
		authorizedJobs = {'inspecteur'},
		locked = true,
		maxDistance = 2.00
	},
	{
		textCoords = vector3(-448.2, 6008.05, 31.7),
		authorizedJobs = {'inspecteur'},
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('v_ilev_ss_door8'), objHeading = 315.0, objCoords = vector3(-447.7, 6007.5, 31.7)},
			{objHash = GetHashKey('v_ilev_ss_door7'), objHeading = 135.0, objCoords = vector3(-448.7, 6008.3, 31.7)}
		}
	},
	{
		textCoords = vector3(-442.4, 6012.3, 31.7),
		authorizedJobs = {'inspecteur'},
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('v_ilev_bk_door2'), objHeading = 45.0, objCoords = vector3(-441.7, 6012.6, 31.7)},
			{objHash = GetHashKey('v_ilev_bk_door2'), objHeading = 225.0, objCoords = vector3(-442.6, 6011.7, 31.7)}
		}
	},

	-- CONCESS
	{
		textCoords = vector3(-38.20, -1108.38, 26.43),
		authorizedJobs = {'cardealer'},
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('v_ilev_csr_door_r'), objHeading = -20.0, objCoords = vector3(-37.49, -1108.38, 25.43)},
			{objHash = GetHashKey('v_ilev_csr_door_l'), objHeading = -20.0, objCoords = vector3(-38.55, -1107.88, 25.43)}
		}
	},
	{
		textCoords = vector3(-59.70, -1094.0076, 26.42),
		authorizedJobs = {'cardealer'},
		locked = true,
		maxDistance = 2.5,
		doors = {
			{objHash = GetHashKey('v_ilev_csr_door_r'), objHeading = -110.0, objCoords = vector3(-59.94, -1094.479, 26.61)},
			{objHash = GetHashKey('v_ilev_csr_door_l'), objHeading = -110.0, objCoords = vector3(-59.55, -1093.4012, 26.61)}
		}
	},
	{
		objHash = GetHashKey('v_ilev_fib_door1'),
		objHeading = 70.0,
		objCoords = vector3(-32.315, -1102.36, 26.42),
		textCoords = vector3(-32.315, -1102.36, 26.42),
		authorizedJobs = {'cardealer'},
		locked = true,
		maxDistance = 1.50
	},
	{
		objHash = GetHashKey('v_ilev_fib_door1'),
		objHeading = 70.0,
		objCoords = vector3(-34.356, -1108.156, 26.42),
		textCoords = vector3(-34.356, -1108.156, 26.42),
		authorizedJobs = {'cardealer'},
		locked = true,
		maxDistance = 1.50
	},

	-- Rooftop
	{
		objHash = GetHashKey('v_ilev_gtdoor02'),
		objHeading = 90.0,
		objCoords = vector3(464.3, -984.6, 43.8),
		textCoords = vector3(464.3, -984.0, 44.8),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},
	-- Hallway to roof
	{
		objHash = GetHashKey('v_ilev_arm_secdoor'),
		objHeading = 90.0,
		objCoords = vector3(461.2, -985.3, 30.8),
		textCoords = vector3(461.5, -986.0, 31.5),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},
	-- Armory
	{
		objHash = GetHashKey('v_ilev_arm_secdoor'),
		objHeading = 270.0,
		objCoords = vector3(452.6, -982.7, 30.6),
		textCoords = vector3(453.0, -982.6, 31.7),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},
	-- Captain Office
	{
		objHash = GetHashKey('v_ilev_ph_gendoor002'),
		objHeading = 180.0,
		objCoords = vector3(447.2, -980.6, 30.6),
		textCoords = vector3(447.2, -980.0, 31.7),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},
	-- To downstairs (double doors)
	{
		textCoords = vector3(444.6, -989.4, 31.7),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 4,
		doors = {
			{objHash = GetHashKey('v_ilev_ph_gendoor005'), objHeading = 180.0, objCoords = vector3(443.9, -989.0, 30.6)},
			{objHash = GetHashKey('v_ilev_ph_gendoor005'), objHeading = 0.0, objCoords = vector3(445.3, -988.7, 30.6)}
		}
	},
	-- Main Cells
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 0.0,
		objCoords = vector3(463.8, -992.6, 24.9),
		textCoords = vector3(463.3, -992.6, 25.1),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},
	-- Cell 1
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 270.0,
		objCoords = vector3(462.3, -993.6, 24.9),
		textCoords = vector3(461.8, -993.3, 25.0),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},
	-- Cell 2
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 90.0,
		objCoords = vector3(462.3, -998.1, 24.9),
		textCoords = vector3(461.8, -998.8, 25.0),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},
	-- Cell 3
	{
		objHash = GetHashKey('v_ilev_ph_cellgate'),
		objHeading = 90.0,
		objCoords = vector3(462.7, -1001.9, 24.9),
		textCoords = vector3(461.8, -1002.4, 25.0),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},
	-- To Back
	{
		objHash = GetHashKey('v_ilev_gtdoor'),
		objHeading = 0.0,
		objCoords = vector3(463.4, -1003.5, 25.0),
		textCoords = vector3(464.0, -1003.5, 25.5),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 1.25
	},
	-- Back (double doors)
	{
		textCoords = vector3(468.6, -1014.4, 27.1),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 4,
		doors = {
			{objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 0.0, objCoords  = vector3(467.3, -1014.4, 26.5)},
			{objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 180.0, objCoords  = vector3(469.9, -1014.4, 26.5)}
		}
	},
	-- Back Gate
	{
		objHash = GetHashKey('hei_prop_station_gate'),
		objHeading = 90.0,
		objCoords = vector3(488.8, -1017.2, 27.1),
		textCoords = vector3(488.8, -1020.2, 30.0),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 14,
		size = 2
	},
	-- Unicorn (Patron Rue)
	{
		objHash = GetHashKey('prop_magenta_door'),
		objCoords = vector3(96.019,  -1284.853,  29.438),
		textCoords = vector3(95.419,  -1284.853,  29.438),
		authorizedJobs = { 'unicorn' },
		locked = true,
		maxDistance = 2.5

	},
	-- Unicorn (Vestiaire)
	{
		objHash = GetHashKey('v_ilev_door_orangesolid'),
		objCoords = vector3(113.982,  -1297.430,  29.418),
		textCoords = vector3(113.982,  -1296.730,  29.418),
		authorizedJobs = { 'unicorn' },
		locked = true,
		maxDistance = 2.5

	},
	-- Unicorn (Entrée)
	{
		objHash = GetHashKey('prop_strip_door_01'),
		objCoords = vector3(127.955,  -1298.503,  29.419),
		textCoords = vector3(128.555,  -1298.503,  29.419),
		authorizedJobs = { 'unicorn' },
		locked = true,
		maxDistance = 2.5

	},
	--- faction jason
	{
		objHash = GetHashKey('apa_p_mp_door_apart_door'),
		objCoords = vector3(-1290.33,  454.62,  90.29),
		textCoords = vector3(-1290.33,  454.62,  91.29),
		authorizedJobs = { 'nightclub' },
		locked = true,
		maxDistance = 2.5

	},
	{
		objHash = GetHashKey('apa_p_mp_door_apart_door'),
		objCoords = vector3(-1289.57,  441.19,  94.09),
		textCoords = vector3(-1289.57,  441.19,  95.09),
		authorizedJobs = { 'nightclub' },
		locked = true,
		maxDistance = 2.5

	},
	{
		objHash = GetHashKey('v_ilev_abbmaindoor'),
		objCoords  = vector3(962.33,  -2184.9,  30.47),
		textCoords = vector3(962.33,  -2184.9,  30.47),
		authorizedJobs = { 'blanchisseur' },  -- job2
		locked = true,
		maxDistance = 2.5

	},
	{
		objHash = GetHashKey('prop_abat_slide'),
		objCoords  = vector3(962.53,  -2105.82,  31.55),
		textCoords = vector3(962.73,  -2105.82,  32.55),
		authorizedJobs = { 'blanchisseur' }, -- job2
		locked = true,
		maxDistance = 15.5

	},
}
Config          = {}
Config.Locale   = 'fr'

Config.JEKYLLE = {
    Bornes = {
		"Tête",
		"Main Gauche",
		"Main Droite",
		"Jambe Gauche",
		"Jambe Droite",
		"Pied Gauche",
		"Pied Droit",
		"Bras Gauche",
		"Bras Droit",
		"Oeil Gauche", 
		"Oeil Droit",
	--	"Torse"
	},

	Ped = {
		{label = "Tigre", value = "a_c_mtlion"},
		{label = "Aigle", value = "a_c_chickenhawk"},
		{label = "Loup", value = "a_c_coyote"}
	},

	Tete = {
		{label = "Enlever les flammes", value = "remove"},
		{label = "Petite flamme", value = "fire_wrecked_train"},
		{label = "Petite flamme 2", value = "fire_petroltank_car_bullet"},
		{label = "Petite flamme 3", value = "fire_wrecked_car"},
		{label = "Petite flamme 4", value = "ent_amb_barrel_fire"},
		{label = "Petite flamme 5", value = "fire_wrecked_truck"},
		{label = "Petite flamme 6", value = "fire_wrecked_bike"},
		{label = "Petite flamme 7", value = "fire_object"},
		{label = "Petite flamme 8", value = "fire_wrecked_boat"},
		{label = "Petite flamme 9", value = "ent_amb_int_fireplace_sml"},
		{label = "Petite flamme 10", value = "fire_vehicle"},
		{label = "Petite flamme 10", value = "fire_map_slow"},
		{label = "Moyenne flamme", value = "fire_wrecked_plane_cockpit"},
		{label = "Moyenne flamme 2", value = "ent_amb_fbi_fire_door"},
		{label = "Moyenne flamme 3", value = "fire_petroltank_truck"},
		{label = "Moyenne flamme 4", value = "fire_wrecked_truck_vent"},
		{label = "Moyenne flamme 5", value = "fire_wrecked_car_vent"},
		{label = "Moyenne flamme 6", value = "ent_amb_fbi_fire_dub_door"},
		{label = "Moyenne flamme 7", value = "fire_ped_body"},
		{label = "Enorme flamme", value = "ent_ray_meth_fires"},
		{label = "Enorme flamme 2", value = "fire_wrecked_tank"},
		{label = "Enorme flamme 3", value = "fire_wrecked_heli_cockpit"},
		{label = "Enorme flamme 4", value = "ent_amb_fbi_fire_wall_lg"},
		{label = "Enorme flamme 5", value = "fire_wrecked_plane"},
		{label = "Enorme flamme 6", value = "ent_ray_heli_aprtmnt_h_fire"},
		{label = "Enorme flamme 7", value = "ent_amb_fbi_fire_lg"},
		{label = "Enorme flamme 8", value = "fire_wrecked_tank_cockpit"},
		{label = "Enorme flamme 9", value = "fire_wrecked_bus"},
		{label = "Gigantesque flamme", value = "ent_ray_ch2_farm_fire_u_l"},
		{label = "Gigantesque flamme 2", value = "ent_ray_heli_aprtmnt_s_fire"},
		{label = "Gigantesque flamme 3", value = "ent_ray_ch2_farm_fire_l_l_l"},
		{label = "Giga méga flamme qui tue", value = "ent_ray_heli_aprtmnt_l_fire"},
		{label = "Petit cercle en flamme", value = "fire_wheel_bike"},
		{label = "Gros cercle en flamme", value = "ent_amb_fire_ring"},
		{label = "Gros cercle en flamme 2", value = "fire_wheel"},
		{label = "Haute flamme", value = "ent_amb_fbi_fire_beam"},
		{label = "Haute flamme 2", value = "ent_ray_heli_aprtmnt_s_fire_sq"},
		{label = "Trainée de flamme", value = "ent_amb_torch_fire"},
		{label = "Trainée de flamme 2", value = "ent_amb_beach_campfire"},
		{label = "Trainée de flamme 3", value = "ent_ray_finale1_fire"},
		{label = "Trainée de flamme 4", value = "fire_map_quick"},
		{label = "Trainée de flamme 5", value = "fire_wrecked_rc"},
		{label = "Trainée de flamme bleu", value = "fire_petrol_two"},
		{label = "Trainée de flamme bleu 2", value = "fire_petrol_pool"},
		{label = "Trainée de flamme qui va vers le bas", value = "veh_exhaust_heli_misfire"},
		{label = "Trainée de flamme qui va vers l'arrière", value = "veh_exhaust_heli_cargobob_misfire"},
		{label = "Petite Trainée de flamme qui va vers l'arrière", value = "veh_exhaust_plane_misfire"},
		{label = "Toute Petite Trainée de flamme qui va vers l'arrière", value = "veh_exhaust_misfire"},
		{label = "Petits éclats de flamme", value = "ent_amb_fire_gaswork"},
		{label = "Petits éclats de feux qui tombe par terre", value = "ent_amb_fbi_fire_drip"},
		{label = "Boule de feux", value = "ent_amb_fbi_fire_fogball"}, 
		{label = "Plusieurs flammes autour de vous", value = "ent_ray_paleto_gas_window_fire"},
		{label = "Nuage de flamme allant vers le haut", value = "fire_petroltank_bike"},
		{label = "Nuage de flamme allant vers le haut 2", value = "ent_amb_fbi_fire_wall_sm"},
	},

	FumeeTete = {
		{label = "Enlever les fumée", value = "remove"},
		{label = "Fumée 1", value = "fire_extinguish"},
		{label = "Fumée 2", value = "ent_amb_smoke_general"},
		{label = "Fumée 3", value = "mp_parachute_smoke"},
		{label = "Fumée 4", value = "proj_grenade_smoke"},
		{label = "Fumée 5", value = "ent_amb_fbi_smoke_stair_gather"},
		{label = "Fumée 6", value = "ent_amb_smoke_foundry_white"},
		{label = "Fumée 7", value = "weap_smoke_grenade"},
		{label = "Fumée 8", value = "ent_amb_smoke_factory_white"},
		{label = "Fumée 9", value = "ent_amb_fbi_door_smoke"},
		{label = "Fumée 10", value = "ent_amb_smoke_factory"},
		{label = "Fumée 11", value = "ent_amb_fbi_smoke_edge_lip"},
	},

	FumeeJambe = {
		{label = "Enlever les fumée", value = "remove"},
		{label = "Fumée 1", value = "fire_extinguish"},
		{label = "Fumée 2", value = "ent_amb_smoke_general"},
		{label = "Fumée 3", value = "mp_parachute_smoke"},
		{label = "Fumée 4", value = "proj_grenade_smoke"},
		{label = "Fumée 5", value = "ent_amb_fbi_smoke_stair_gather"},
		{label = "Fumée 6", value = "ent_amb_smoke_foundry_white"},
		{label = "Fumée 7", value = "weap_smoke_grenade"},
		{label = "Fumée 8", value = "ent_amb_smoke_factory_white"},
		{label = "Fumée 9", value = "ent_amb_fbi_door_smoke"},
		{label = "Fumée 10", value = "ent_amb_smoke_factory"},
		{label = "Fumée 11", value = "ent_amb_fbi_smoke_edge_lip"},
	},

	FumeeBras = {
		{label = "Enlever les fumée", value = "remove"},
		{label = "Fumée 1", value = "fire_extinguish"},
		{label = "Fumée 2", value = "ent_amb_smoke_general"},
		{label = "Fumée 3", value = "mp_parachute_smoke"},
		{label = "Fumée 4", value = "proj_grenade_smoke"},
		{label = "Fumée 5", value = "ent_amb_fbi_smoke_stair_gather"},
		{label = "Fumée 6", value = "ent_amb_smoke_foundry_white"},
		{label = "Fumée 7", value = "weap_smoke_grenade"},
		{label = "Fumée 8", value = "ent_amb_smoke_factory_white"},
		{label = "Fumée 9", value = "ent_amb_fbi_door_smoke"},
		{label = "Fumée 10", value = "ent_amb_smoke_factory"},
		{label = "Fumée 11", value = "ent_amb_fbi_smoke_edge_lip"},
	},

	FumeePied = {
		{label = "Enlever les fumée", value = "remove"},
		{label = "Fumée 1", value = "fire_extinguish"},
		{label = "Fumée 2", value = "ent_amb_smoke_general"},
		{label = "Fumée 3", value = "mp_parachute_smoke"},
		{label = "Fumée 4", value = "proj_grenade_smoke"},
		{label = "Fumée 5", value = "ent_amb_fbi_smoke_stair_gather"},
		{label = "Fumée 6", value = "ent_amb_smoke_foundry_white"},
		{label = "Fumée 7", value = "weap_smoke_grenade"},
		{label = "Fumée 8", value = "ent_amb_smoke_factory_white"},
		{label = "Fumée 9", value = "ent_amb_fbi_door_smoke"},
		{label = "Fumée 10", value = "ent_amb_smoke_factory"},
		{label = "Fumée 11", value = "ent_amb_fbi_smoke_edge_lip"},
	},

	FumeeOeil = {
		{label = "Enlever les fumée", value = "remove"},
		{label = "Fumée 1", value = "fire_extinguish"},
		{label = "Fumée 2", value = "ent_amb_smoke_general"},
		{label = "Fumée 3", value = "mp_parachute_smoke"},
		{label = "Fumée 4", value = "proj_grenade_smoke"},
		{label = "Fumée 5", value = "ent_amb_fbi_smoke_stair_gather"},
		{label = "Fumée 6", value = "ent_amb_smoke_foundry_white"},
		{label = "Fumée 7", value = "weap_smoke_grenade"},
		{label = "Fumée 8", value = "ent_amb_smoke_factory_white"},
		{label = "Fumée 9", value = "ent_amb_fbi_door_smoke"},
		{label = "Fumée 10", value = "ent_amb_smoke_factory"},
		{label = "Fumée 11", value = "ent_amb_fbi_smoke_edge_lip"},
	},

	FumeeMain = {
		{label = "Enlever les fumée", value = "remove"},
		{label = "Fumée 1", value = "fire_extinguish"},
		{label = "Fumée 2", value = "ent_amb_smoke_general"},
		{label = "Fumée 3", value = "mp_parachute_smoke"},
		{label = "Fumée 4", value = "proj_grenade_smoke"},
		{label = "Fumée 5", value = "ent_amb_fbi_smoke_stair_gather"},
		{label = "Fumée 6", value = "ent_amb_smoke_foundry_white"},
		{label = "Fumée 7", value = "weap_smoke_grenade"},
		{label = "Fumée 8", value = "ent_amb_smoke_factory_white"},
		{label = "Fumée 9", value = "ent_amb_fbi_door_smoke"},
		{label = "Fumée 10", value = "ent_amb_smoke_factory"},
		{label = "Fumée 11", value = "ent_amb_fbi_smoke_edge_lip"},
	},
	

	Main = {
		{label = "Enlever les flammes", value = "remove"},
		{label = "Petite flamme", value = "fire_wrecked_train"},
		{label = "Petite flamme 2", value = "fire_petroltank_car_bullet"},
		{label = "Petite flamme 3", value = "fire_wrecked_car"},
		{label = "Petite flamme 4", value = "ent_amb_barrel_fire"},
		{label = "Petite flamme 5", value = "fire_wrecked_truck"},
		{label = "Petite flamme 6", value = "fire_wrecked_bike"},
		{label = "Petite flamme 7", value = "fire_object"},
		{label = "Petite flamme 8", value = "fire_wrecked_boat"},
		{label = "Petite flamme 9", value = "ent_amb_int_fireplace_sml"},
		{label = "Petite flamme 10", value = "fire_vehicle"},
		{label = "Petite flamme 10", value = "fire_map_slow"},
		{label = "Moyenne flamme", value = "fire_wrecked_plane_cockpit"},
		{label = "Moyenne flamme 2", value = "ent_amb_fbi_fire_door"},
		{label = "Moyenne flamme 3", value = "fire_petroltank_truck"},
		{label = "Moyenne flamme 4", value = "fire_wrecked_truck_vent"},
		{label = "Moyenne flamme 5", value = "fire_wrecked_car_vent"},
		{label = "Moyenne flamme 6", value = "ent_amb_fbi_fire_dub_door"},
		{label = "Moyenne flamme 7", value = "fire_ped_body"},
		{label = "Enorme flamme", value = "ent_ray_meth_fires"},
		{label = "Enorme flamme 2", value = "fire_wrecked_tank"},
		{label = "Enorme flamme 3", value = "fire_wrecked_heli_cockpit"},
		{label = "Enorme flamme 4", value = "ent_amb_fbi_fire_wall_lg"},
		{label = "Enorme flamme 5", value = "fire_wrecked_plane"},
		{label = "Enorme flamme 6", value = "ent_ray_heli_aprtmnt_h_fire"},
		{label = "Enorme flamme 7", value = "ent_amb_fbi_fire_lg"},
		{label = "Enorme flamme 8", value = "fire_wrecked_tank_cockpit"},
		{label = "Enorme flamme 9", value = "fire_wrecked_bus"},
		{label = "Gigantesque flamme", value = "ent_ray_ch2_farm_fire_u_l"},
		{label = "Gigantesque flamme 2", value = "ent_ray_heli_aprtmnt_s_fire"},
		{label = "Gigantesque flamme 3", value = "ent_ray_ch2_farm_fire_l_l_l"},
		{label = "Giga méga flamme qui tue", value = "ent_ray_heli_aprtmnt_l_fire"},
		{label = "Petit cercle en flamme", value = "fire_wheel_bike"},
		{label = "Gros cercle en flamme", value = "ent_amb_fire_ring"},
		{label = "Gros cercle en flamme 2", value = "fire_wheel"},
		{label = "Haute flamme", value = "ent_amb_fbi_fire_beam"},
		{label = "Haute flamme 2", value = "ent_ray_heli_aprtmnt_s_fire_sq"},
		{label = "Trainée de flamme", value = "ent_amb_torch_fire"},
		{label = "Trainée de flamme 2", value = "ent_amb_beach_campfire"},
		{label = "Trainée de flamme 3", value = "ent_ray_finale1_fire"},
		{label = "Trainée de flamme 4", value = "fire_map_quick"},
		{label = "Trainée de flamme 5", value = "fire_wrecked_rc"},
		{label = "Trainée de flamme bleu", value = "fire_petrol_two"},
		{label = "Trainée de flamme bleu 2", value = "fire_petrol_pool"},
		{label = "Trainée de flamme qui va vers le bas", value = "veh_exhaust_heli_misfire"},
		{label = "Trainée de flamme qui va vers l'arrière", value = "veh_exhaust_heli_cargobob_misfire"},
		{label = "Petite Trainée de flamme qui va vers l'arrière", value = "veh_exhaust_plane_misfire"},
		{label = "Toute Petite Trainée de flamme qui va vers l'arrière", value = "veh_exhaust_misfire"},
		{label = "Petits éclats de flamme", value = "ent_amb_fire_gaswork"},
		{label = "Petits éclats de feux qui tombe par terre", value = "ent_amb_fbi_fire_drip"},
		{label = "Boule de feux", value = "ent_amb_fbi_fire_fogball"},
		{label = "Plusieurs flammes autour de vous", value = "ent_ray_paleto_gas_window_fire"},
		{label = "Nuage de flamme allant vers le haut", value = "fire_petroltank_bike"},
		{label = "Nuage de flamme allant vers le haut 2", value = "ent_amb_fbi_fire_wall_sm"},
	},
	
	Jambe = {
		{label = "Enlever les flammes", value = "remove"},
		{label = "Petite flamme", value = "fire_wrecked_train"},
		{label = "Petite flamme 2", value = "fire_petroltank_car_bullet"},
		{label = "Petite flamme 3", value = "fire_wrecked_car"},
		{label = "Petite flamme 4", value = "ent_amb_barrel_fire"},
		{label = "Petite flamme 5", value = "fire_wrecked_truck"},
		{label = "Petite flamme 6", value = "fire_wrecked_bike"},
		{label = "Petite flamme 7", value = "fire_object"},
		{label = "Petite flamme 8", value = "fire_wrecked_boat"},
		{label = "Petite flamme 9", value = "ent_amb_int_fireplace_sml"},
		{label = "Petite flamme 10", value = "fire_vehicle"},
		{label = "Petite flamme 10", value = "fire_map_slow"},
		{label = "Moyenne flamme", value = "fire_wrecked_plane_cockpit"},
		{label = "Moyenne flamme 2", value = "ent_amb_fbi_fire_door"},
		{label = "Moyenne flamme 3", value = "fire_petroltank_truck"},
		{label = "Moyenne flamme 4", value = "fire_wrecked_truck_vent"},
		{label = "Moyenne flamme 5", value = "fire_wrecked_car_vent"},
		{label = "Moyenne flamme 6", value = "ent_amb_fbi_fire_dub_door"},
		{label = "Moyenne flamme 7", value = "fire_ped_body"},
		{label = "Enorme flamme", value = "ent_ray_meth_fires"},
		{label = "Enorme flamme 2", value = "fire_wrecked_tank"},
		{label = "Enorme flamme 3", value = "fire_wrecked_heli_cockpit"},
		{label = "Enorme flamme 4", value = "ent_amb_fbi_fire_wall_lg"},
		{label = "Enorme flamme 5", value = "fire_wrecked_plane"},
		{label = "Enorme flamme 6", value = "ent_ray_heli_aprtmnt_h_fire"},
		{label = "Enorme flamme 7", value = "ent_amb_fbi_fire_lg"},
		{label = "Enorme flamme 8", value = "fire_wrecked_tank_cockpit"},
		{label = "Enorme flamme 9", value = "fire_wrecked_bus"},
		{label = "Gigantesque flamme", value = "ent_ray_ch2_farm_fire_u_l"},
		{label = "Gigantesque flamme 2", value = "ent_ray_heli_aprtmnt_s_fire"},
		{label = "Gigantesque flamme 3", value = "ent_ray_ch2_farm_fire_l_l_l"},
		{label = "Giga méga flamme qui tue", value = "ent_ray_heli_aprtmnt_l_fire"},
		{label = "Petit cercle en flamme", value = "fire_wheel_bike"},
		{label = "Gros cercle en flamme", value = "ent_amb_fire_ring"},
		{label = "Gros cercle en flamme 2", value = "fire_wheel"},
		{label = "Haute flamme", value = "ent_amb_fbi_fire_beam"},
		{label = "Haute flamme 2", value = "ent_ray_heli_aprtmnt_s_fire_sq"},
		{label = "Trainée de flamme", value = "ent_amb_torch_fire"},
		{label = "Trainée de flamme 2", value = "ent_amb_beach_campfire"},
		{label = "Trainée de flamme 3", value = "ent_ray_finale1_fire"},
		{label = "Trainée de flamme 4", value = "fire_map_quick"},
		{label = "Trainée de flamme 5", value = "fire_wrecked_rc"},
		{label = "Trainée de flamme bleu", value = "fire_petrol_two"},
		{label = "Trainée de flamme bleu 2", value = "fire_petrol_pool"},
		{label = "Trainée de flamme qui va vers le bas", value = "veh_exhaust_heli_misfire"},
		{label = "Trainée de flamme qui va vers l'arrière", value = "veh_exhaust_heli_cargobob_misfire"},
		{label = "Petite Trainée de flamme qui va vers l'arrière", value = "veh_exhaust_plane_misfire"},
		{label = "Toute Petite Trainée de flamme qui va vers l'arrière", value = "veh_exhaust_misfire"},
		{label = "Petits éclats de flamme", value = "ent_amb_fire_gaswork"},
		{label = "Petits éclats de feux qui tombe par terre", value = "ent_amb_fbi_fire_drip"},
		{label = "Boule de feux", value = "ent_amb_fbi_fire_fogball"},
		{label = "Plusieurs flammes autour de vous", value = "ent_ray_paleto_gas_window_fire"},
		{label = "Nuage de flamme allant vers le haut", value = "fire_petroltank_bike"},
		{label = "Nuage de flamme allant vers le haut 2", value = "ent_amb_fbi_fire_wall_sm"},
	},
	
	Pied = {
		{label = "Enlever les flammes", value = "remove"},
		{label = "Petite flamme", value = "fire_wrecked_train"},
		{label = "Petite flamme 2", value = "fire_petroltank_car_bullet"},
		{label = "Petite flamme 3", value = "fire_wrecked_car"},
		{label = "Petite flamme 4", value = "ent_amb_barrel_fire"},
		{label = "Petite flamme 5", value = "fire_wrecked_truck"},
		{label = "Petite flamme 6", value = "fire_wrecked_bike"},
		{label = "Petite flamme 7", value = "fire_object"},
		{label = "Petite flamme 8", value = "fire_wrecked_boat"},
		{label = "Petite flamme 9", value = "ent_amb_int_fireplace_sml"},
		{label = "Petite flamme 10", value = "fire_vehicle"},
		{label = "Petite flamme 10", value = "fire_map_slow"},
		{label = "Moyenne flamme", value = "fire_wrecked_plane_cockpit"},
		{label = "Moyenne flamme 2", value = "ent_amb_fbi_fire_door"},
		{label = "Moyenne flamme 3", value = "fire_petroltank_truck"},
		{label = "Moyenne flamme 4", value = "fire_wrecked_truck_vent"},
		{label = "Moyenne flamme 5", value = "fire_wrecked_car_vent"},
		{label = "Moyenne flamme 6", value = "ent_amb_fbi_fire_dub_door"},
		{label = "Moyenne flamme 7", value = "fire_ped_body"},
		{label = "Enorme flamme", value = "ent_ray_meth_fires"},
		{label = "Enorme flamme 2", value = "fire_wrecked_tank"},
		{label = "Enorme flamme 3", value = "fire_wrecked_heli_cockpit"},
		{label = "Enorme flamme 4", value = "ent_amb_fbi_fire_wall_lg"},
		{label = "Enorme flamme 5", value = "fire_wrecked_plane"},
		{label = "Enorme flamme 6", value = "ent_ray_heli_aprtmnt_h_fire"},
		{label = "Enorme flamme 7", value = "ent_amb_fbi_fire_lg"},
		{label = "Enorme flamme 8", value = "fire_wrecked_tank_cockpit"},
		{label = "Enorme flamme 9", value = "fire_wrecked_bus"},
		{label = "Giga méga flamme qui tue", value = "ent_ray_heli_aprtmnt_l_fire"},
		{label = "Haute flamme 2", value = "ent_ray_heli_aprtmnt_s_fire_sq"},
		{label = "Trainée de flamme", value = "ent_amb_torch_fire"},
		{label = "Trainée de flamme 2", value = "ent_amb_beach_campfire"},
		{label = "Trainée de flamme 3", value = "ent_ray_finale1_fire"},
		{label = "Trainée de flamme 4", value = "fire_map_quick"},
		{label = "Trainée de flamme 5", value = "fire_wrecked_rc"},
		{label = "Trainée de flamme bleu", value = "fire_petrol_two"},
		{label = "Trainée de flamme bleu 2", value = "fire_petrol_pool"},

		{label = "Petits éclats de flamme", value = "ent_amb_fire_gaswork"},
		{label = "Nuage de flamme allant vers le haut", value = "fire_petroltank_bike"},
	},
	
	Bras = {
		{label = "Enlever les flammes", value = "remove"},
		{label = "Petite flamme", value = "fire_wrecked_train"},
		{label = "Petite flamme 2", value = "fire_petroltank_car_bullet"},
		{label = "Petite flamme 3", value = "fire_wrecked_car"},
		{label = "Petite flamme 4", value = "ent_amb_barrel_fire"},
		{label = "Petite flamme 5", value = "fire_wrecked_truck"},
		{label = "Petite flamme 6", value = "fire_wrecked_bike"},
		{label = "Petite flamme 7", value = "fire_object"},
		{label = "Petite flamme 8", value = "fire_wrecked_boat"},
		{label = "Petite flamme 9", value = "ent_amb_int_fireplace_sml"},
		{label = "Petite flamme 10", value = "fire_vehicle"},
		{label = "Petite flamme 10", value = "fire_map_slow"},
		{label = "Moyenne flamme", value = "fire_wrecked_plane_cockpit"},
		{label = "Moyenne flamme 2", value = "ent_amb_fbi_fire_door"},
		{label = "Moyenne flamme 3", value = "fire_petroltank_truck"},
		{label = "Moyenne flamme 4", value = "fire_wrecked_truck_vent"},
		{label = "Moyenne flamme 5", value = "fire_wrecked_car_vent"},
		{label = "Moyenne flamme 6", value = "ent_amb_fbi_fire_dub_door"},
		{label = "Moyenne flamme 7", value = "fire_ped_body"},
		{label = "Enorme flamme", value = "ent_ray_meth_fires"},
		{label = "Enorme flamme 2", value = "fire_wrecked_tank"},
		{label = "Enorme flamme 3", value = "fire_wrecked_heli_cockpit"},
		{label = "Enorme flamme 4", value = "ent_amb_fbi_fire_wall_lg"},
		{label = "Enorme flamme 5", value = "fire_wrecked_plane"},
		{label = "Enorme flamme 6", value = "ent_ray_heli_aprtmnt_h_fire"},
		{label = "Enorme flamme 7", value = "ent_amb_fbi_fire_lg"},
		{label = "Enorme flamme 8", value = "fire_wrecked_tank_cockpit"},
		{label = "Enorme flamme 9", value = "fire_wrecked_bus"},
		{label = "Gigantesque flamme", value = "ent_ray_ch2_farm_fire_u_l"},
		{label = "Gigantesque flamme 2", value = "ent_ray_heli_aprtmnt_s_fire"},
		{label = "Gigantesque flamme 3", value = "ent_ray_ch2_farm_fire_l_l_l"},
		{label = "Giga méga flamme qui tue", value = "ent_ray_heli_aprtmnt_l_fire"},
		{label = "Petit cercle en flamme", value = "fire_wheel_bike"},
		{label = "Gros cercle en flamme", value = "ent_amb_fire_ring"},
		{label = "Gros cercle en flamme 2", value = "fire_wheel"},
		{label = "Haute flamme", value = "ent_amb_fbi_fire_beam"},
		{label = "Haute flamme 2", value = "ent_ray_heli_aprtmnt_s_fire_sq"},
		{label = "Trainée de flamme", value = "ent_amb_torch_fire"},
		{label = "Trainée de flamme 2", value = "ent_amb_beach_campfire"},
		{label = "Trainée de flamme 3", value = "ent_ray_finale1_fire"},
		{label = "Trainée de flamme 4", value = "fire_map_quick"},
		{label = "Trainée de flamme 5", value = "fire_wrecked_rc"},
		{label = "Trainée de flamme bleu", value = "fire_petrol_two"},
		{label = "Trainée de flamme bleu 2", value = "fire_petrol_pool"},
		{label = "Trainée de flamme qui va vers le bas", value = "veh_exhaust_heli_misfire"},
		{label = "Trainée de flamme qui va vers l'arrière", value = "veh_exhaust_heli_cargobob_misfire"},
		{label = "Petite Trainée de flamme qui va vers l'arrière", value = "veh_exhaust_plane_misfire"},
		{label = "Toute Petite Trainée de flamme qui va vers l'arrière", value = "veh_exhaust_misfire"},
		{label = "Petits éclats de flamme", value = "ent_amb_fire_gaswork"},
		{label = "Petits éclats de feux qui tombe par terre", value = "ent_amb_fbi_fire_drip"},
		{label = "Boule de feux", value = "ent_amb_fbi_fire_fogball"},
		{label = "Plusieurs flammes autour de vous", value = "ent_ray_paleto_gas_window_fire"},
		{label = "Nuage de flamme allant vers le haut", value = "fire_petroltank_bike"},
		{label = "Nuage de flamme allant vers le haut 2", value = "ent_amb_fbi_fire_wall_sm"},
	},
	
	Oeil = {
		{label = "Enlever les flammes", value = "remove"},
		{label = "Oeil en feux styler", value = "ent_amb_int_fireplace_sml"},
		{label = "Oeil en feu styler 2", value = "fire_petroltank_truck"},
		{label = "Flamme qui sort de l'oeil", value = "fire_wrecked_truck_vent"},
		{label = "Petits éclats de feux qui tombe par terre", value = "ent_amb_fbi_fire_drip"},
		{label = "Petits éclat de feux qui sortent", value = "fire_wrecked_boat"},
		{label = "Petits éclat de feux qui sortent 2", value = "fire_vehicle"},
		{label = "Petits éclat de feux qui sortent 3", value = "ent_amb_fbi_fire_dub_door"},
		{label = "Petits éclat de feux qui sortent 4", value = "fire_petroltank_bike"},
	},
	
	Torse = {
		{label = "Enlever les flammes", value = "remove"},
		{label = "Petite flamme", value = "fire_wrecked_train"},
		{label = "Petite flamme 2", value = "fire_petroltank_car_bullet"},
		{label = "Petite flamme 3", value = "fire_wrecked_car"},
		{label = "Petite flamme 4", value = "ent_amb_barrel_fire"},
		{label = "Petite flamme 5", value = "fire_wrecked_truck"},
		{label = "Petite flamme 6", value = "fire_wrecked_bike"},
		{label = "Petite flamme 7", value = "fire_object"},
		{label = "Petite flamme 8", value = "fire_wrecked_boat"},
		{label = "Petite flamme 10", value = "fire_map_slow"},
		{label = "Moyenne flamme 3", value = "fire_petroltank_truck"},
		{label = "Moyenne flamme 4", value = "fire_wrecked_truck_vent"},
		{label = "Moyenne flamme 5", value = "fire_wrecked_car_vent"},
		{label = "Moyenne flamme 6", value = "ent_amb_fbi_fire_dub_door"},
		{label = "Moyenne flamme 7", value = "fire_ped_body"},
		{label = "Enorme flamme", value = "ent_ray_meth_fires"},
		{label = "Enorme flamme 2", value = "fire_wrecked_tank"},
		{label = "Enorme flamme 3", value = "fire_wrecked_heli_cockpit"},
		{label = "Enorme flamme 4", value = "ent_amb_fbi_fire_wall_lg"},
		{label = "Enorme flamme 5", value = "fire_wrecked_plane"},
		{label = "Enorme flamme 6", value = "ent_ray_heli_aprtmnt_h_fire"},
		{label = "Enorme flamme 7", value = "ent_amb_fbi_fire_lg"},
		{label = "Enorme flamme 8", value = "fire_wrecked_tank_cockpit"},
		{label = "Enorme flamme 9", value = "fire_wrecked_bus"},
		{label = "Gigantesque flamme", value = "ent_ray_ch2_farm_fire_u_l"},
		{label = "Gigantesque flamme 2", value = "ent_ray_heli_aprtmnt_s_fire"},
		{label = "Gigantesque flamme 3", value = "ent_ray_ch2_farm_fire_l_l_l"},
		{label = "Giga méga flamme qui tue", value = "ent_ray_heli_aprtmnt_l_fire"},
		{label = "Petit cercle en flamme", value = "fire_wheel_bike"},
		{label = "Gros cercle en flamme", value = "ent_amb_fire_ring"},
		{label = "Gros cercle en flamme 2", value = "fire_wheel"},
		{label = "Haute flamme", value = "ent_amb_fbi_fire_beam"},
		{label = "Haute flamme 2", value = "ent_ray_heli_aprtmnt_s_fire_sq"},
		{label = "Trainée de flamme", value = "ent_amb_torch_fire"},
		{label = "Trainée de flamme 2", value = "ent_amb_beach_campfire"},
		{label = "Trainée de flamme 3", value = "ent_ray_finale1_fire"},
		{label = "Trainée de flamme 4", value = "fire_map_quick"},
		{label = "Trainée de flamme 5", value = "fire_wrecked_rc"},
		{label = "Trainée de flamme bleu", value = "fire_petrol_two"},
		{label = "Trainée de flamme bleu 2", value = "fire_petrol_pool"},
		{label = "Trainée de flamme qui va vers le bas", value = "veh_exhaust_heli_misfire"},
		{label = "Trainée de flamme qui va vers l'arrière", value = "veh_exhaust_heli_cargobob_misfire"},
		{label = "Petite Trainée de flamme qui va vers l'arrière", value = "veh_exhaust_plane_misfire"},
		{label = "Toute Petite Trainée de flamme qui va vers l'arrière", value = "veh_exhaust_misfire"},
		{label = "Petits éclats de flamme", value = "ent_amb_fire_gaswork"},
		{label = "Petits éclats de feux qui tombe par terre", value = "ent_amb_fbi_fire_drip"},
		{label = "Boule de feux", value = "ent_amb_fbi_fire_fogball"},
		{label = "Plusieurs flammes autour de vous", value = "ent_ray_paleto_gas_window_fire"},
		{label = "Nuage de flamme allant vers le haut", value = "fire_petroltank_bike"},
		{label = "Nuage de flamme allant vers le haut 2", value = "ent_amb_fbi_fire_wall_sm"},
	},
	
	Combo = {
		{label = "Enlever les flammes", value = "remove"},
		{label = "Trainée de feux", value = "trainée"},
		{label = "Trainée de feux bleu", value = "ok"},
		{label = "Yeux en feux", value = "yeux"},
		{label = "Yeux en feux 2", value = "yeux"},
		{label = "Tête + Mains en feux", value = "wow"},
		{label = "Pieds en feux", value = "xd"},
		{label = "Mettre le feux au sol quand on marche", value = ""},
		{label = "Mettre le corps avec effet electricité", value = "ok"}
	},
	
	FumeeCombo = {
		{label = "Enlever la fumée", value = "remove"},
		{label = "Mettre le tout le corps en fumée", value = ""}
    },
}
/datum/disease/beesease
	name = "Beesease"
	form = "Infection"
	max_stages = 4
	spread_text = "On contact"
	spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_CONTACT_FLUIDS
	cure_text = "Sugar"
	cures = list(/datum/reagent/consumable/sugar)
	agent = "Apidae Infection"
	viable_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	desc = ""
	severity = DISEASE_SEVERITY_MEDIUM
	infectable_biotypes = MOB_ORGANIC|MOB_UNDEAD //bees nesting in corpses

/datum/disease/beesease/stage_act()
	..()
	switch(stage)
		if(2) //also changes say, see say.dm
			if(prob(2))
				to_chat(affected_mob, "<span class='notice'>I taste honey in my mouth.</span>")
		if(3)
			if(prob(10))
				to_chat(affected_mob, "<span class='notice'>My stomach rumbles.</span>")
			if(prob(2))
				to_chat(affected_mob, "<span class='danger'>My stomach stings painfully.</span>")
				if(prob(20))
					affected_mob.adjustToxLoss(2)
					affected_mob.updatehealth()
		if(4)
			if(prob(10))
				affected_mob.visible_message("<span class='danger'>[affected_mob] buzzes.</span>", \
												"<span class='danger'>My stomach buzzes violently!</span>")
			if(prob(5))
				to_chat(affected_mob, "<span class='danger'>I feel something moving in my throat.</span>")
			if(prob(1))
				affected_mob.visible_message("<span class='danger'>[affected_mob] coughs up a swarm of bees!</span>", \
													"<span class='danger'>I cough up a swarm of bees!</span>")
				new /mob/living/simple_animal/hostile/poison/bees(affected_mob.loc)
	return

enum reagent_frames
{
	BLACK_PEARL		=0,
	BLOOD_MOSS		=1,
	NIGHTSHADE		=2,
	MANDRAKE_ROOT	=3,
	GARLIC			=4,
	GINSENG			=5,
	SPIDER_SILK		=6,
	SULPHUROUS_ASH	=7
};


void Apparatus shape#(0x2ed) ()
{
	if(event == DOUBLECLICK)
	{
		var	mandrake	=AVATAR->get_cont_items(SHAPE_REAGENT, QUALITY_ANY, MANDRAKE_ROOT);
		if(mandrake)
		{
			var	pos			=AVATAR->get_object_position();
			var	manaPotion	=UI_create_new_object(SHAPE_POTION);

			manaPotion->set_item_flag(OKAY_TO_TAKE);
			manaPotion->set_item_frame(MANA_POTION);

			UI_update_last_created(pos);

			item_say("@Created a mana potion!@");

			mandrake->remove_item();
		}
		else
		{
			AVATAR.say("Out of Mandrake root.");
		}
	}
	else
	{
		AVATAR.say("Bloop.");
	}
}
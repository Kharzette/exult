/*
 *	This source file contains some generic utility functions.
 *
 *	Author: Marzo Junior
 *	Last Modified: 2001-01-20
 */

avatarSpeak 0xC00(var msg)
{
	//Show correct gender-based face for Avatar:
	UI_show_npc_face(AVATAR, UI_is_pc_female());
	//Have Avatar say his piece:
	say(msg);
}

//Sets BG_DONT_MOVE flag:
trueFreeze()	{ item->set_item_flag(BG_DONT_MOVE); }
//Clears BG_DONT_MOVE flag:
trueUnfreeze()	{ item->clear_item_flag(BG_DONT_MOVE); }
//Puts an NPC in casting mode:
showCastingFrames () { item->begin_casting_mode(); }

freezeParty ()
{
	var party;
	var count;
	var index;
	var member;
	var rand;

	//Get party list:
	party = UI_get_party_list();
	//Random NPC for bark:
	rand = UI_get_random(count - 1) + 1;
	for (member in party with index to count)
	{
		//For each NPC in party,
		//freeze NPC:
		member->trueFreeze();
		//This is the randomly chosen NPC which barks something:
		if (rand == index) script member {wait 4; say "@I am frozen in place!@";}
	}
}

unfreezeParty ()
{
	var party;
	var count;
	var index;
	var member;

	//Get party list:
	party = UI_get_party_list();
	for (member in party with index to count)
		//Unfreeze all party members:
		member->trueUnfreeze(true);
}

var createContainerWithObjects (var cont_shape, var item_shapes, var item_frames, var item_quantity, var item_quality)
{
	var shape_count = UI_get_array_size(item_shapes);
	var counter;
	var obj;
	
	var num;
	var max;
	
	//Create a container from the desired shape:
	var cont = UI_create_new_object(cont_shape);
	//Allow Avatar to take it without problems:
	cont->set_item_flag(OKAY_TO_TAKE);
	//Make it temporary:
	cont->set_item_flag(TEMPORARY);
	
	while (counter < shape_count)
	{
		//Increment counter:
		counter = counter + 1;
		
		if (item_quantity[counter])
		{
			//Create the object:
			obj = UI_create_new_object(item_shapes[counter]);
			
			//Set its frame:
			obj->set_item_frame(item_frames[counter]);
			
			//Set its quality
			obj->set_item_quality(item_quality[counter]);
			
			//Make it okay to take and temporary:
			obj->set_item_flag(OKAY_TO_TAKE);
			obj->set_item_flag(TEMPORARY);
			
			//Try to set quantity; if the item does not have a quantity,
			//the intrinsic will return 0:
			if (!obj->set_item_quantity(item_quantity[counter]))
			{
				//Since the item does not have a quantity, we have to create
				//each item individually.
	
				//Place the last object in the container:
				cont->give_last_created();
				
				//Repeat the creation-setting-giving proccess:
				num = 1;
				while (num < item_quantity[counter])
				{
					num = num + 1;
					obj = UI_create_new_object(item_shapes[counter]);
					obj->set_item_frame(item_frames[counter]);
					obj->set_item_quality(item_quality[counter]);
					obj->set_item_flag(OKAY_TO_TAKE);
					obj->set_item_flag(TEMPORARY);
			
					//Place the last object in the container:
					cont->give_last_created();
				}
			}
			
			else
			{
				//The item has a quantity, and it has been correctly set.
				
				//Place it in the container:
				cont->give_last_created();
			}
		}
	}
	
	return cont;
}

var giveToParty(var obj)
{
	//Get party list:
	var party = UI_get_party_list();
	var npc;
	var index;
	var count;
	
	//Set the desired object as being the last created:
	obj->set_last_created();
	for (npc in party with index to count)
	{
		//For each npc in the party,
		//try to give item to NPC:
		if (npc->give_last_created())
		{
			//If successful, see if it is the Avatar:
			if (npc != UI_get_avatar_ref())
			{
				//It isn't; have the NPC pop up and say it
				//will take the item:
				npc.say("@I'll take it!@");
				npc.hide();
			}
			//Success:
			return true;
		}
	}
	//Failure:
	return false;
}

sellItems (var options, var shapes, var frames, var price, var quantity, var articles, var quantity_text, var quantity_tokens, var dialog)
{
	var choice_index;
	var msg;
	var sell_result;
	var total_price;
	var isplural;
	
	//Present the options to the player:
	choice_index = chooseFromMenu2(options);
	
	//Keep doing this until the player choses not to buy anything else:
	while (!(choice_index==1))
	{
		total_price = price[choice_index] * quantity[choice_index];

		if (quantity[choice_index] > 1)
			isplural = true;
		else
			isplural = false;
			
		//Inform price to player:
		say("@^" + makeSellPriceString(articles[choice_index], options[choice_index], isplural, price[choice_index], quantity_text[choice_index]) + dialog[1]);
		
		//See if player agrees with price:
		if (askYesNo())
		{
			//Ask for quantity:
			say(dialog[2] + quantity_tokens[choice_index] + dialog[3]);
			
			//Sell everything to the party:
			sell_result = sellAmountToParty(shapes[choice_index], frames[choice_index], quantity[choice_index], price[choice_index], 32, 1, true);
			
			if (sell_result == 1)
				msg = dialog[4];
			else if (sell_result == 2)
				msg = dialog[5];
			else if (sell_result == 3)
				msg = dialog[6];
			else
				msg = dialog[7];

			//Inform the player if the buy was successful:
			say(msg);
		}
		
		else say(dialog[8]);
		
		//Present the menu again:
		choice_index = chooseFromMenu2(options);
	}

	say(dialog[9]);
}
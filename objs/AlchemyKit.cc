/*
Copyright (C) 2001-2013 The Exult Team

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
*/
#ifdef HAVE_CONFIG_H
#  include <config.h>
#endif

#include "AlchemyKit.h"
#include "objiter.h"
#include "exult.h"
#include "ShortcutBar_gump.h"
#include "ignore_unused_variable_warning.h"

const int	REAGENTS	=842;       // Shape #.


bool	AlchemyKit::add(
	Game_object	*pObj,
	bool		dont_check,	//1 to skip volume/recursion check.
	bool		combine,	//True to try to combine obj.  MAY
							//	cause obj to be deleted.
	bool		noset)		//True to prevent actors from setting sched. weapon.
{
	ignore_unused_variable_warning(noset);
	
	if(!Container_game_object::add(obj, dont_check, combine))
	{
		return	false; // Can't be added to.
	}

	//only allow reagents
	if(!IsReagent(obj))
	{
		return	false;
	}

	//I have no idea what this does yet, copied from jawbone
	if(g_shortcutBar)
	{
		g_shortcutBar->set_changed();
	}
	return	true;
}


bool	AlchemyKit::IsReagent(const Game_object *pThing) const
{
	int	shapeNum	=pThing->get_shapenum();

	//this might get more complex if I add some
	//such as one for negation
	return	(shapeNum == REAGENTS);
}

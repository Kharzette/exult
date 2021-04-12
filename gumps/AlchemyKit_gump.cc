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

#include "game.h"
#include "AlchemyKit_gump.h"
#include "contain.h"
#include "gamewin.h"
#include "objiter.h"
#include "misc_buttons.h"
#include "AlchemyKit.h"
#include "ignore_unused_variable_warning.h"


AlchemyKit_gump::AlchemyKit_gump(AlchemyKit_object	*pKit,
	int initx, int inity)        // Coords. on screen.
	: Gump(cont, initx, inity, game->get_shape("gumps/alchemykit")),
	mpKit(pKit) {
	set_object_area(TileRect(0, 0, 138, 116), 10, 109);
}

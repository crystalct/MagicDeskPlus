/** \file   settings_magicdesk.c
 * \brief   Settings widget to control Magic Desk resources
 *
 * \author  Bas Wassink <b.wassink@ziggo.nl>
 */

/*
 * $VICERES MagicDeskPlus         x64 x64sc xscpu64 x128
 * $VICERES MagicDeskSRAMImage    x64 x64sc xscpu64 x128
 * $VICERES MagicDeskSRAMRW       x64 x64sc xscpu64 x128
 * $VICERES MagicDeskSRAMWrite    x64 x64sc xscpu64 x128
 * $VICERES MagicDeskEEPROMImage  x64 x64sc xscpu64 x128
 * $VICERES MagicDeskEEPROMRW     x64 x64sc xscpu64 x128
 * $VICERES MagicDeskEEPROMWrite  x64 x64sc xscpu64 x128
 */

/*
 * This file is part of VICE, the Versatile Commodore Emulator.
 * See README for copyright notice.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
 *  02111-1307  USA.
 *
 */

#include "vice.h"
#include <gtk/gtk.h>

#include "cartridge.h"
#include "vice_gtk3.h"

#include "settings_magicdesk.h"


/** \brief  Handler for the 'toggled' event of the "Enable Plus emulation" check button
 *
 * Update sensitivity of the SRAM cart image widget's save/flush buttons when
 * enabling or disabling Magic Desk Plus emulation.
 *
 * \param[in]   self        check button (unused)
 * \param[in]   secondary   SRAM cartridge image widget
 */
static void on_enable_toggled(GtkWidget *self, gpointer secondary)
{
    cart_image_widget_update_sensitivity(GTK_WIDGET(secondary));
}


/** \brief  Create widget to control Magic Desk resources
 *
 * \param[in]   parent  parent widget, used for dialogs
 *
 * \return  GtkGrid
 */
GtkWidget *settings_magicdesk_widget_create(GtkWidget *parent)
{
    GtkWidget *grid;
    GtkWidget *enable;
    GtkWidget *primary;
    GtkWidget *secondary;
    GtkWidget *tertiary;

    grid = gtk_grid_new();
    gtk_grid_set_row_spacing(GTK_GRID(grid), 32);

    /* enable button */
    enable = vice_gtk3_resource_check_button_new("MagicDeskPlus",
                                                 "Enable " CARTRIDGE_NAME_MAGIC_DESK
                                                 " Plus emulation");

    /* primary image: ROM */
    primary = cart_image_widget_new(CARTRIDGE_MAGIC_DESK,
                                    CARTRIDGE_NAME_MAGIC_DESK,
                                    CART_IMAGE_PRIMARY,
                                    "cartridge",
                                    NULL,
                                    TRUE,
                                    TRUE);

    /* secondary image: 128KB SRAM */
    secondary = cart_image_widget_new(CARTRIDGE_MAGIC_DESK,
                                      CARTRIDGE_NAME_MAGIC_DESK,
                                      CART_IMAGE_SECONDARY,
                                      "SRAM",
                                      "MagicDeskSRAMImage",
                                      TRUE,
                                      TRUE);
    cart_image_widget_append_check(secondary,
                                   "MagicDeskSRAMRW",
                                   "Enable writes to " CARTRIDGE_NAME_MAGIC_DESK
                                   " SRAM image");
    cart_image_widget_append_check(secondary,
                                   "MagicDeskSRAMWrite",
                                   "Save SRAM image on exit");

    /* tertiary image: parallel EEPROM */
    tertiary = cart_image_widget_new(CARTRIDGE_MAGIC_DESK,
                                     CARTRIDGE_NAME_MAGIC_DESK,
                                     CART_IMAGE_TERTIARY,
                                     "EEPROM",
                                     "MagicDeskEEPROMImage",
                                     TRUE,
                                     TRUE);
    cart_image_widget_append_check(tertiary,
                                   "MagicDeskEEPROMRW",
                                   "Enable writes to " CARTRIDGE_NAME_MAGIC_DESK
                                   " EEPROM image");
    cart_image_widget_append_check(tertiary,
                                   "MagicDeskEEPROMWrite",
                                   "Save EEPROM image on exit");

    gtk_grid_attach(GTK_GRID(grid), enable,    0, 0, 1, 1);
    gtk_grid_attach(GTK_GRID(grid), primary,   0, 1, 1, 1);
    gtk_grid_attach(GTK_GRID(grid), secondary, 0, 2, 1, 1);
    gtk_grid_attach(GTK_GRID(grid), tertiary,  0, 3, 1, 1);

    /* update SRAM save/flush button sensitivity when Plus emulation is toggled */
    g_signal_connect(G_OBJECT(enable),
                     "toggled",
                     G_CALLBACK(on_enable_toggled),
                     (gpointer)secondary);

    gtk_widget_show_all(grid);
    return grid;
}


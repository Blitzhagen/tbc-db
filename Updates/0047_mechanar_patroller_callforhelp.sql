-- Fix #4099: Tempest-Forge Patroller (19166) uses the default
-- CreatureFamilyAssistanceRadius of 5yd, so pulling it does not call the
-- adjacent spawn-group packs standing ~20-27yd away. Raise its call-for-help
-- radius to 30yd so the whole pack receives the assistance call at once.
UPDATE `creature_template` SET `CallForHelp` = 30 WHERE `entry` = 19166;

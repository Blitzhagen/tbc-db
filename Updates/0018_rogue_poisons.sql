-- Fix rogue poison skill not being taught by class trainers
-- Spell 2842 (Poisons) is normally a quest reward; this change makes it
-- trainable from every rogue trainer at level 20.  Learning 2842 also
-- automatically grants Instant Poison I (spell 8681) via spell_learn_spell.
--
-- Additionally the poison recipes are gated behind the Poisons skill (40)
-- so they cannot be purchased before the rogue can actually use them and
-- will appear in the spell book once the skill is known.

-- Add the Poisons skill to the rogue trainer templates
DELETE FROM `npc_trainer_template` WHERE `entry` IN (40,41,2030) AND `spell` = 2842;
INSERT INTO `npc_trainer_template` (`entry`,`spell`,`spellcost`,`reqskill`,`reqskillvalue`,`reqlevel`,`ReqAbility1`,`ReqAbility2`,`ReqAbility3`,`condition_id`) VALUES
(40,2842,0,0,0,20,NULL,NULL,NULL,0),
(41,2842,0,0,0,20,NULL,NULL,NULL,0),
(2030,2842,0,0,0,20,NULL,NULL,NULL,0);

-- Add the Poisons skill to the one non-template rogue trainer
DELETE FROM `npc_trainer` WHERE `entry` = 22005 AND `spell` = 2842;
INSERT INTO `npc_trainer` (`entry`,`spell`,`spellcost`,`reqskill`,`reqskillvalue`,`reqlevel`,`ReqAbility1`,`ReqAbility2`,`ReqAbility3`,`condition_id`) VALUES
(22005,2842,0,0,0,20,NULL,NULL,NULL,0);

-- Gate the poison recipes behind the Poisons skill so they are only
-- trainable when the rogue actually knows the Poisons skill (spell 2842)
UPDATE `npc_trainer_template` SET `reqskill` = 40, `reqskillvalue` = 1
WHERE `entry` IN (41,2030)
  AND `spell` IN (2835,2836,2837,3420,3421,5763,13220,13228,13229,13230,26786,27282);

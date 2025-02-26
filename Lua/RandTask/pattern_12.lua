--================================================================
-- 
-- 配置
-- 
--================================================================

-- 怪物
monsters = {
	{ config_id = 12001, monster_id = 20030101, pos = { x = 1.1, y = -0.2, z = -1.4 }, rot = { x = 0.0, y = 0.0, z = 0.0 }, level = 1, drop_tag = "雷萤", disableWander = true },
	{ config_id = 12002, monster_id = 20030101, pos = { x = -0.9, y = 0.1, z = 1.7 }, rot = { x = 0.0, y = 79.5, z = 0.0 }, level = 1, drop_tag = "雷萤", disableWander = true },
	{ config_id = 12003, monster_id = 20030101, pos = { x = 2.5, y = 0.4, z = 1.8 }, rot = { x = 0.0, y = 191.2, z = 0.0 }, level = 1, drop_tag = "雷萤", disableWander = true },
	{ config_id = 12004, monster_id = 20030101, pos = { x = -0.9, y = -0.2, z = -0.9 }, rot = { x = 0.0, y = 41.2, z = 0.0 }, level = 1, drop_tag = "雷萤", disableWander = true },
	{ config_id = 12005, monster_id = 20030101, pos = { x = 0.4, y = 0.2, z = 2.3 }, rot = { x = 0.0, y = 181.0, z = 0.0 }, level = 1, drop_tag = "雷萤", disableWander = true },
	{ config_id = 12008, monster_id = 20030201, pos = { x = 2.6, y = 0.1, z = -0.5 }, rot = { x = 0.0, y = 191.2, z = 0.0 }, level = 1, drop_tag = "雷萤", disableWander = true },
	{ config_id = 12009, monster_id = 20030201, pos = { x = 1.9, y = 0.4, z = 2.4 }, rot = { x = 0.0, y = 191.2, z = 0.0 }, level = 1, drop_tag = "雷萤", disableWander = true },
	{ config_id = 12010, monster_id = 20030201, pos = { x = -0.2, y = 0.1, z = 1.3 }, rot = { x = 0.0, y = 191.2, z = 0.0 }, level = 1, drop_tag = "雷萤", disableWander = true },
	{ config_id = 12011, monster_id = 20030201, pos = { x = -0.2, y = -0.3, z = -1.7 }, rot = { x = 0.0, y = 191.2, z = 0.0 }, level = 1, drop_tag = "雷萤", disableWander = true }
}

-- NPC
npcs = {
}

-- 装置
gadgets = {
}

-- 区域
regions = {
	{ config_id = 12007, shape = RegionShape.SPHERE, radius = 50, pos = { x = -0.1, y = 0.0, z = 0.0 } }
}

-- 触发器
triggers = {
	{ name = "ANY_MONSTER_DIE_12006", event = EventType.EVENT_ANY_MONSTER_DIE, source = "", condition = "condition_EVENT_ANY_MONSTER_DIE_12006", action = "action_EVENT_ANY_MONSTER_DIE_12006" },
	{ name = "ENTER_REGION_12007", event = EventType.EVENT_ENTER_REGION, source = "", condition = "condition_EVENT_ENTER_REGION_12007", action = "action_EVENT_ENTER_REGION_12007", forbid_guest = false }
}

-- 变量
variables = {
}

--================================================================
-- 
-- 初始化配置
-- 
--================================================================

-- 初始化时创建
init_config = {
	suite = 1,
	end_suite = 0,
	rand_suite = true
}

--================================================================
-- 
-- 小组配置
-- 
--================================================================

suites = {
	{
		-- suite_id = 1,
		-- description = suite_2,
		monsters = { 12001, 12002, 12003, 12004, 12005 },
		gadgets = { },
		regions = { },
		triggers = { "ANY_MONSTER_DIE_12006" },
		rand_weight = 100
	},
	{
		-- suite_id = 2,
		-- description = suite_3,
		monsters = { 12008, 12009, 12010, 12011 },
		gadgets = { },
		regions = { },
		triggers = { "ANY_MONSTER_DIE_12006" },
		rand_weight = 100
	}
}

--================================================================
-- 
-- 触发器
-- 
--================================================================

-- 触发条件
function condition_EVENT_ANY_MONSTER_DIE_12006(context, evt)
	-- 判断剩余怪物数量是否是0
	if ScriptLib.GetGroupMonsterCount(context) ~= 0 then
		return false
	end
	
	return true
end

-- 触发操作
function action_EVENT_ANY_MONSTER_DIE_12006(context, evt)
	-- 设置操作台选项
	
	    ScriptLib.FinishRandTask(context, 12, true)
	
	
	return 0
end

-- 触发条件
function condition_EVENT_ENTER_REGION_12007(context, evt)
	if evt.param1 ~= 12007 then return false end
	
	-- 判断角色数量不少于1
	if ScriptLib.GetRegionEntityCount(context, { region_eid = evt.source_eid, entity_type = EntityType.AVATAR }) < 1 then
		return false
	end
	
	return true
end

-- 触发操作
function action_EVENT_ENTER_REGION_12007(context, evt)
	-- 调用提示id为 1110013 的提示UI，会显示在屏幕中央偏下位置，id索引自 ReminderData表格
	if 0 ~= ScriptLib.ShowReminder(context, 1110013) then
		return -1
	end
	
	return 0
end

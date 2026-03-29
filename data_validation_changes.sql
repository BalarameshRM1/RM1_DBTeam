
--to check all modules respective screens for all roles screen permissions
select mm.id as module_id,mm.module_name,
ms.id as screen_id,ms.screen_name,ms.screen_label,ms.fa_fa_icon,ms.routes,
msp.role_id,mr.role_name,msp.can_view,msp.can_edit,msp.can_delete,msp.can_access,msp.can_update
from master_module mm 
left join master_screen ms on ms.module_id = mm.id and mm.is_active = true 
left join master_screen_permission msp on msp.module_id = mm.id and msp.module_id = ms.id and mm.is_active = true 
left join master_role mr on mr.id = msp.role_id and mr.is_active = true

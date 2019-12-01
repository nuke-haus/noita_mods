
local me = GetUpdatedEntityID()
local comp = EntityGetFirstComponent(me, "ParticleEmitterComponent")

ComponentSetValue(comp, "lifetime_min", "5.0")
ComponentSetValue(comp, "lifetime_max", "6.0")
ComponentSetValue(comp, "airflow_force", "0.25")
ComponentSetValue(comp, "airflow_scale", "0.25")
ComponentSetValue(comp, "count_min", "20")
ComponentSetValue(comp, "count_max", "24")
ComponentSetValue(comp, "image_animation_emission_probability", "0.99")

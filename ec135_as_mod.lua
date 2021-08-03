--
-- script to tune the artifical stability (AS) settings for the Rotorsim EC135 V5
--     melbo @x-plane.org - 20210803
--

if ( PLANE_ICAO == "EC35" ) then   -- only do that for the EC135

  dataref("low_speed","sim/aircraft/artstability/acf_ASloV","writable")
  dataref("high_speed","sim/aircraft/artstability/acf_AShiV","writable")
  dataref("low_pitch","sim/aircraft/artstability/acf_ASp_lo_rate","writable")
  dataref("low_roll","sim/aircraft/artstability/acf_ASr_lo_rate","writable")
  --dataref("low_yaw","sim/aircraft/artstability/acf_ASh_lo_rate","writable")

  local org_low_speed = low_speed    -- save original values
  local org_high_speed = high_speed  -- save original values

  function setLowSpeed()
    if ( low_speed == org_low_speed) then
      low_speed = 1000
      high_speed = 1001
      XPLMSpeakString("high speed disabled")        
    else
      low_speed = org_low_speed
      high_speed = org_high_speed
      XPLMSpeakString("high speed set to original")        
    end
  end

  function adjustSAS()            -- override plugin values
    --if ( low_yaw == 0 ) then    -- 0 should be ok on YAW
    --  low_yaw = 0.0001
    --end
    if ( low_pitch == 0 ) then    -- 0 on PITCH makes it too nervous
      low_pitch = 0.008
    end
    if ( low_roll == 0 ) then     -- 0 on ROLL makes it too nervous
      low_roll = 0.008
    end
  end

  setLowSpeed()

  do_often("adjustSAS()")

  create_command("FlyWithLua/toggleLowSpeed", "toggle AS low speed", "setLowSpeed()", "", "")
end



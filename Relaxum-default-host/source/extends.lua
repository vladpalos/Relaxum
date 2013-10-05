--==================================================================================================
-- 	Copyright (c) 2010-2012 Red Fruits Games, Inc.
-- 	All Rights Reserved.
-- 	http://www.redfruits.com
--==================================================================================================

--
--	Some MOAI functionality extend
--

MOAIProp2D.extend( 'MOAIProp2D',  
    function( interface, class, superInterface, superClass )  
        function interface.setOpacity( self, opacity )
            self:setColor( self:getAttr( MOAIColor.ATTR_R_COL ) * opacity, 
            			   self:getAttr( MOAIColor.ATTR_G_COL ) * opacity,
            			   self:getAttr( MOAIColor.ATTR_B_COL ) * opacity,
            			   opacity )
        end
    end
)

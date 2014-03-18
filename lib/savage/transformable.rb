require 'bigdecimal'
require 'bigdecimal/util'

module Savage

  module Transformable

    # Matrix 2D:
    # | a, c, e |
    # | b, d, f |
    # | 0, 0, 1 |
    def transform(a, b, c, d, e, f)
    end

    def translate(tx, ty=0)
      transform( 1, 0, 0, 1, tx, ty )
    end

    def scale(sx, sy=sx)
      transform( sx, 0, 0, sy, 0, 0 )
    end

    # Public: rotate by angle degrees
    # 
    # - angle : rotation in degrees
    # - cx    : center x
    # - cy    : center y
    #
    # Returns nil
    #
    # TODO:
    # make cx, cy be origin center
    def rotate( angle, cx=0, cy=0 )
      a = (angle.to_f/180).to_d * Math::PI
      translate( cx, cy )
      transform( Math.cos(a),  Math.sin(a), -Math.sin(a), Math.cos(a), 0, 0)
      translate( -cx, -cy )
    end

    def skew_x( angle )
      a = angle.to_f/180 * Math::PI
      transform( 1, 0, Math.tan(a), 1, 0, 0 )
    end

    def skew_y( angle )
      a = angle.to_f/180 * Math::PI
      transform( 1, Math.tan(a), 0, 1, 0, 0 )
    end

    protected

      def transform_dot( dot, a, b, c, d, e, f )
        x, y  = dot.x, dot.y
        dot.x = x*a + y*c + e
        dot.y = x*b + y*d + f
      end

  end
end

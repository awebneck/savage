require 'bigdecimal'
require 'bigdecimal/util'

module Savage

  module Transformable

    # Matrix:
    def transform(scale_x, skew_x, skew_y, scale_y, tx, ty)
    end

    def translate(tx, ty=0)
      transform( 1, 0, 0, 1, tx, ty )
    end

    def scale(sx, sy=sx)
      transform( sx, 0, 0, sy, 0, 0 )
    end

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

      def transform_dot( dot, scale_x, skew_x, skew_y, scale_y, tx, ty )
        x, y  = dot.x, dot.y
        dot.x = x*scale_x + y*skew_x  + tx
        dot.y = x*skew_y  + y*scale_y + ty

        dot.x = dot.x.to_short_f
        dot.y = dot.y.to_short_f
      end

  end
end

unless ::Object.instance_methods.include? :to_short_f
  class ::Object

    def to_short_f( precision=4 )
      factor = 10 ** precision
      rnd = (to_f * factor).round.to_f / factor
      f, i = rnd, rnd.to_i
      f == i ? i : f
    end
    
  end
end


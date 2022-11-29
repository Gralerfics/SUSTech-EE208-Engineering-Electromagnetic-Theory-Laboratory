classdef Point
    % Point

    properties
        x
        y
        z
    end

    properties(Dependent)
        mat_
    end
    
    methods
        function obj = Point(p)
            obj.x = p(1);
            if (length(p) >= 2)
                obj.y = p(2);
            end
            if (length(p) >= 3)
                obj.z = p(3);
            end
        end

        function mat_ = get.mat_(obj)
            mat_ = [obj.x; obj.y; obj.z];
        end

        function y = minus(a, b)
            if (isa(b, "Point"))
                y = Vector(a.mat_ - b.mat_);
            elseif (isa(b, "Vector"))
                y = Point(a.mat_ - b.mat_);
            end
        end
    end
end

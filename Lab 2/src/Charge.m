classdef Charge
    % Charge

    properties
        q
        p
    end
    
    methods
        function obj = Charge(q, p)                                         % Constructor
            obj.q = q;
            obj.p = p;
        end

        function d = EvalDistance(obj, p)
            displacement = obj.p - p;
            d = displacement.length;
        end

        function V = EvalPotentialField(obj, x_mesh, y_mesh)
            [n_y, n_x] = size(x_mesh);
            V = zeros(n_y, n_x);
            for x_idx = 1 : n_x
                for y_idx = 1 : n_y
                    r_ = obj.EvalDistance(Point([x_mesh(y_idx, x_idx), y_mesh(y_idx, x_idx)]));
                    V(y_idx, x_idx) = Constants.k * obj.q / r_;
                end
            end
        end
    end
end

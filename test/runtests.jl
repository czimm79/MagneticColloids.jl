using MagneticColloids
using Test
using Unitful, LinearAlgebra

@testset "MagneticColloids.jl" begin
    # setup
    test_r = [5, 0.0]u"µm"
    test_m = [2.00664e-13, 0.0]u"A*m^2"

    @testset "Field" begin
        # Equations from other sources
        Bₓ_lit(l, m, θ) = μ₀ * m / (4π) * ((3*cos(θ)^2 - 1) / l^3)  # from https://tiggerntatie.github.io/emagnet/offaxis/mmoffaxis.htm

        function B_magmethods(r, m)
            # from petruska et al. magnetic methods paper

            @assert length(r) == length(m)  # r and m should be same dimensions
            r̂ = r / norm(r)  # r\hat
            
            ans = (μ₀/(4π * norm(r)^3) * (3*r̂*r̂' - one(r̂*r̂')) ) * m
            ans .|> u"mT"
        end
        
        # 1D test
        literature = Bₓ_lit(test_r[1], test_m[1], 0) |> u"mT"  # x coordinate
        magmethods = B_magmethods(test_r, test_m)[1]  # x coordinate
        @test isapprox(literature, magmethods)
        
        # nD test
        @test isapprox(B_magmethods(test_r, test_m), B(test_r, test_m))
    end

    @testset "Force" begin
        # Equation from biswal paper
        function f_biswal(rᵢⱼ, mᵢ, mⱼ)
            @assert length(rᵢⱼ) == length(mᵢ) == length(mⱼ)
            
            prefactor = 3μ₀/(4π*norm(rᵢⱼ)^5)
        
            A = (mᵢ⋅rᵢⱼ)*mⱼ + (mⱼ⋅rᵢⱼ)*mᵢ + (mᵢ⋅mⱼ)*rᵢⱼ - 5*(mᵢ⋅rᵢⱼ)*(mⱼ⋅rᵢⱼ)/norm(rᵢⱼ)^2 * rᵢⱼ
        
            return prefactor * A .|> upreferred
        end
        
        @test isapprox(f(test_r, test_m, test_m), f_biswal(test_r, test_m, test_m))
    end
end




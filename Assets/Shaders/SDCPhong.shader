Shader "Custom/Phong"
{
    Properties 
    {
        _Albedo("Albedo Color", Color) = (1, 1, 1 ,1)
        _SpecularColor("Specular Color", Color) = (1, 1, 1, 1)
        _SpecularPower("Specular Power", Range(1.0, 10.0)) = 5.0
        _SpecularGloss("Specular Gloss", Range(1, 5)) = 1
        _GlossSteps("GlossSteps", Range(1, 8)) = 4
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
            "RenderType" = "Opaque"
        }

        CGPROGRAM

            #pragma surface surf lambert

            half4 _Albedo;
            half4 _SpecularColor;
            half _SpecularPower;
            half _SpecularGloss;
            int _GlossSteps;

            half4 LightingPhongCustom(SurfaceOutput s, half3 LightDir, half3 viewDir, half atten)
            {
                half4 NdotL = max(s.Normal, LightDir);
                half3 reflectedLight = reflect(-LightDir, s.Normal);
                half RdotV = max(reflectedLight, viewDir);
                half specularity = pow(RdotV, _SpecularGloss / _GlossSteps) * _SpecularPower * _SpecularColor.rgb;
                c.rgb = (NdotL * s.Albedo + specularity) * _LightColor0.rgb * atten;
                c.a = s.Alpha;
                return c;
            }

            struct Input
            {
                float a;
            };

            void surf(Input IN, inout SurfaceOutput o)
            {
                o.Albedo = _Albedo.rgb;
            }

        ENDCG
    }
}
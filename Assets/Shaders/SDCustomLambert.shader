Shader "Custom/SDCustomLambert"
{
    Properties
    {
        _Albedo("Albedo Color", Color) = (1, 1, 1, 1)
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
            "RenderType" = "Opaque"
        }
    }

    CGPROGRAM
        #pragma surface surface CustomLambert

        half4 _Albedo;

        half4 lightingCustomLambert (SurfaceOutput s, half3 lightDir, half atten)
        {
            half NdotL = dot(s.Normal, lightDir);
            half4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * NdotL * atten;
            c.a = c.Alpha;
            return c;
        }

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Albedo.rgb;
        }
    ENDCG
}
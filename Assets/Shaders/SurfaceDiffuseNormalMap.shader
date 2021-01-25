Shader "Custom/SurfaceDiffuseNormalMap"
{
    Properties
    {
        _Albedo("Albedo Color", Color) = (1, 1, 1, 1)
        _MainText("Main Texture", 2D) = "white" {}
        _BumpMap("Normal Map", 2D) = "bump" {}
    }

    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
            "RenderType" = "Opaque" 
        }
    

        CGPROGRAM
            half4 _Albedo;
            sampler2D _MainText;
            sampler2D _BumpMap;

            #pragma surface surf Lambert

            struct Input
            {
                float2 uv_MainTex;
                float2 uv_BumpMap;
            };

            void surf(Input IN, inout SurfaceOutput o)
            {
                half4 texColor = tex2D(_MainText, IN.uv_MainTex);
                half4 bumpColor = tex2D(_BumpMap, IN.uv_BumpMap);

                o.Albedo = texColor * _Albedo;
                o.Normal = UnpackNormal(bumpColor);
            }
        
        ENDCG

    }
}
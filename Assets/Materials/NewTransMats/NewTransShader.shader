﻿Shader "Custom/NewTransShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_NoiseTex("NoiseTexture",2D) = "black"{}
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
		_TestPosition("TestPosition",Vector)=(0,0,0,0)
		_TransRange("Circle Radius",Range(1,2))=1.0
	}
	SubShader {
		Tags { "Queue"="Transparent" "RenderType"="Transparent" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows alpha:blend 

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _NoiseTex;

		struct Input {
			float2 uv_MainTex;
			float3 worldPos;
			float2 uv_texcoord;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		float3 _TestPosition;
		fixed _TransRange;
		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 c;
			float dis;
			dis = distance(_TestPosition,IN.worldPos);
			// Albedo comes from a texture tinted by color
			if (dis > _TransRange) {
				c= tex2D(_MainTex, IN.uv_MainTex) * _Color;
			}
			else {
				c = tex2D(_NoiseTex, IN.uv_MainTex)*_Color;
			}
			/*c = tex2D(_MainTex, IN.uv_MainTex) * _Color;*/
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			//default alpha value
			o.Alpha = c.a;
			//first step transparent mat
			/*if (dis < _TransRange&&o.Alpha>0) {
				float alphaCurrent;
				alphaCurrent = o.Alpha;
				alphaCurrent -= 0.1f;
				o.Alpha = alphaCurrent;
			}
			else if(o.Alpha<1)
			{
				float alphaCurrent;
				alphaCurrent = o.Alpha;
				alphaCurrent += 0.1f;
				o.Alpha = alphaCurrent;
			}*/
			//if (dis < _TransRange) {
			//	
			//	o.Alpha = 0;
			//}
			//else /*if (o.Alpha < 1)*/
			//{
			//	/*float alphaCurrent;
			//	alphaCurrent = o.Alpha;
			//	alphaCurrent += 0.1f;*/
			//	o.Alpha = c.a;
			//}
		}
		ENDCG
	}
	FallBack "Diffuse"
}

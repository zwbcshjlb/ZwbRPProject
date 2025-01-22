Shader "ZwbRP/Moon"
{
    Properties
    {
        _MoonColor ("月亮主颜色", Color) = (0.13563, 0.30947, 0.78354, 1.0)
        _7 ("Texture", 2D) = "bump" {}
        _8 ("Texture", 2D) = "white" {}
        _9 ("Texture", 2D) = "white" {}
        _EdgeTransprent("边缘透明度", Range(0, 2)) = 0.8
        _MoonAlpha("整体透明度", Range(0, 1)) = 1.0
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent" }
        Cull Back
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off
        ZTest LEqual

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float4 normal : Normal;
                half2 uv : TEXCOORD0;
                half4 uv2 : TEXCOORD1;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 Varying_v4_A : TEXCOORD0;
                float3 Varying_v3_B : TEXCOORD1;
                half2 Varying_v2_C : TEXCOORD2;
            };

            #define _47_m0 float3(0.00, 6.00, -78.77203)
           /*static const float4x4 _47_m1 = {28.95368, -4.58942E-07, 10.50091, 0.00,
                                     -4.00264, 28.47391, 11.0363, 0.00,
                                     -9.70814, -11.73972, 26.76781, 0.00,
                                     185.9731, 230.89085, -591.68854, 1.00};
            static const float4x4 _47_m2 = {0.03052, -0.00422, -0.01023, 0.00,
                                     -2.61142E-10, 0.03002, -0.01238, 0.00,
                                     0.01107, 0.01163, 0.02822, 0.00,
                                     0.87201, 0.73637, 21.4535, 1.00};
            static const float4x4 _47_m3 = {-1.358, 0.00, 0.00, 0.00,
                                     -0.00011, 2.40217, 0.0993, 0.09922,
                                     0.00115, 0.24082, -0.9959, -0.99507,
                                     0.09109, 4.55712, -79.54472, -78.97868};*/
            
            #define _47_m1 transpose(UNITY_MATRIX_MV)
            //#define _47_m1 transpose(UNITY_MATRIX_M)
            #define _47_m2 transpose(UNITY_MATRIX_V)
            #define _47_m3 transpose(UNITY_MATRIX_P)
            
            #define _47_m4 float3(0.00, 0.00, -78.77203)
            #define _47_m5 float3(0.00, 1.00, 0.00)
            #define _47_m6 0.627
            float _EdgeTransprent;
            float _MoonAlpha;

            float4 GlslToDxClipPos(float4 clipPos) {
                clipPos.y = -clipPos.y;
                clipPos.z = -0.5*clipPos.z + 0.5*clipPos.w;
                return clipPos;
            }

            float4 ZhangToDxClipPos(float4 clipPos)
            {
                clipPos.y = -clipPos.y;
                //clipPos.z = -0.5*clipPos.z + 0.5*clipPos.w;
                return clipPos;
            }

            float4 VulkanToDxClipPos(float4 clipPos)
            {
                clipPos.y /= clipPos.w;
                clipPos.z = (clipPos.z + clipPos.w) / 2.0;
                //clipPos.w = 1.0 / clipPos.w;
                return clipPos;
            }

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                float4 Vertex_Position = v.vertex;
                float3 Vertex_Normal = v.normal;
                half2 Vertex_UV = v.uv;
                half4 Vertex_UV2 = v.uv2;
                
                v2f o;

                float3 _15;
                float4 _18;
                float4 _21;
                float4 _22;
                bool _25;
                float4 _26;
                float _28;
                bool _29;
                float4 _30;
                float4 _31;
                float2 _33;
                float2 _34;
                float _35;
                float _36;
                float _37;
                float _38;
                float _39;
                float _40;
                float _41;
                float4 _55;
                
                _21 = Vertex_Position.yyyy * _47_m1[1u];
                _21 = (_47_m1[0u] * Vertex_Position.xxxx) + _21;
                _21 = (_47_m1[2u] * Vertex_Position.zzzz) + _21;
                _26 = _21 + _47_m1[3u];
                _30 = _26.yyyy * _47_m3[1u].xyww;
                _30 = (_47_m3[0u].xyww * _26.xxxx) + _30;
                _30 = (_47_m3[2u].xyww * _26.zzzz) + _30;
                // gl_Position = (_47_m3[3u].xyww * _26.wwww) + _30;
                // o.vertex = GlslToDxClipPos((_47_m3[3u].xyww * _26.wwww) + _30);
                // o.vertex = ZhangToDxClipPos((_47_m3[3u].xyww * _26.wwww) + _30);
                // o.vertex = (_47_m3[3u].xyww * _26.wwww) + _30;
                o.vertex = UnityObjectToClipPos(v.vertex);
                float3 _130 = _26.xyz + (-_47_m4);
                _26 = float4(_130.x, _130.y, _130.z, _26.w);
                o.Varying_v2_C = Vertex_UV;
                _40 = dot(_21.xyz, _21.xyz);
                _40 = rsqrt(_40);
                float3 _146 = float3(_40, _40, _40) * _21.xyz;
                _30 = float4(_146.x, _146.y, _146.z, _30.w);
                float3 _157 = (_47_m1[3u].xyz * Vertex_Position.www) + _21.xyz;
                _21 = float4(_157.x, _157.y, _157.z, _21.w);
                o.Varying_v3_B = _21.xyz;
                _15 = _30.xyz;
                float3 _170 = _47_m0.yyy * _47_m2[1u].xyz;
                _21 = float4(_170.x, _170.y, _170.z, _21.w);
                float3 _182 = (_47_m2[0u].xyz * _47_m0.xxx) + _21.xyz;
                _21 = float4(_182.x, _182.y, _182.z, _21.w);
                float3 _194 = (_47_m2[2u].xyz * _47_m0.zzz) + _21.xyz;
                _21 = float4(_194.x, _194.y, _194.z, _21.w);
                float3 _202 = _21.xyz + _47_m2[3u].xyz;
                _21 = float4(_202.x, _202.y, _202.z, _21.w);
                float3 _210 = _21.xyz + (-Vertex_Position.xyz);
                _21 = float4(_210.x, _210.y, _210.z, _21.w);
                _40 = dot(_21.xyz, _21.xyz);
                _40 = rsqrt(_40);
                float3 _224 = float3(_40, _40, _40) * _21.xyz;
                _21 = float4(_224.x, _224.y, _224.z, _21.w);
                _33.x = dot(_21.xyz, Vertex_Normal);
                _33.x = clamp(_33.x, 0.0, 1.0);
                _38 = _33.x * 3.0;
                _25 = 0.0 < _33.x;
                _33.x = _38 * _38;
                _33.x *= 1.44269502162933349609375;
                _33.x = exp2(_33.x);
                _33.x = 1.0 / _33.x;
                _36 = (-_33.x) + 1.0;
                o.Varying_v4_A.w = _25 ? _36 : 0.0;
                _33.x = dot(Vertex_Normal, Vertex_Normal);
                _33.x = rsqrt(_33.x);
                _22 = _33.xxxx * Vertex_Normal.yxzy;
                _33.x = dot(Vertex_UV2.xyz, Vertex_UV2.xyz);
                _33.x = rsqrt(_33.x);
                _31 = _33.xxxx * Vertex_UV2.zyyx;
                _33 = float2(_22.z * _31.z, _22.w * _31.w);
                _33 = (_22.xy * _31.xy) + (-_33);
                _33 *= Vertex_UV2.ww;
                _41 = _47_m6 * 6.283185482025146484375;
                _34.x = sin(_41);
                _35 = cos(_41);
                _34.y = -_35;
                _41 = dot(_34, _34);
                _41 = rsqrt(_41);
                _34 = float2(_41, _41) * _34;
                o.Varying_v4_A.y = dot(_33, _34);
                o.Varying_v4_A.x = dot(Vertex_UV2.xz, _34);
                o.Varying_v4_A.z = dot(Vertex_Normal.xz, _34);
                _41 = dot(_26.xyz, _26.xyz);
                _41 = rsqrt(_41);
                float3 _370 = float3(_41, _41, _41) * _26.xyz;
                _26 = float4(_370.x, _370.y, _370.z, _26.w);
                _33.x = dot(_47_m5, _26.xyz);
                _18 = float4(_26.xyz.x, _26.xyz.y, _26.xyz.z, _18.w);
                _26.x = max(_33.x, -1.0);
                _28 = min(_26.x, 1.0);
                _37 = (abs(_28) * (-0.0187292993068695068359375)) + 0.074261002242565155029296875;
                _37 = (_37 * abs(_28)) + (-0.212114393711090087890625);
                _37 = (_37 * abs(_28)) + 1.570728778839111328125;
                _39 = (-abs(_28)) + 1.0;
                _29 = _28 < (-_28);
                _39 = sqrt(_39);
                _41 = _39 * _37;
                _41 = (_41 * (-2.0)) + 3.1415927410125732421875;
                _26.x = _29 ? _41 : 0.0;
                _26.x = (_37 * _39) + _26.x;
                _26.x = (-_26.x) + 1.57079637050628662109375;
                _18.w = _26.x * 0.6366198062896728515625;
                return o;
            }

            #define _52_m0 float3(0.00, 6.00, -78.91365)
            #define _52_m1 float3(0.00, 0.00, -78.91364)
            #define _52_m2 float3(0.00, 1.00, 0.00)
            #define _52_m3 float3(0.0487, 0.22209, 0.73884)
            #define _52_m4 float3(0.028, 0.04134, 0.22091)
            #define _52_m5 0.50569
            #define _52_m6 float3(0.01299, 0.02958, 0.17804)
            #define _52_m7 0.62187
            #define _52_m8 0.21033
            #define _52_m9 float3(0.28709, -0.95179, -0.10801)
            half4 _MoonColor;
            #define _52_m11 7.01662
            #define _52_m12 0.00
            #define _52_m13 float3(0.00, 0.00, 0.00)
            #define _52_m14 float4(0.00, 0.00, 0.00, 0.00)
            #define _52_m15 float4(0.00, 0.00, 0.00, 0.00)
            #define _52_m16 0.00
            #define _52_m17 1.00

            sampler2D _7;
            sampler2D _8;
            sampler2D _9;

            float3 _23;
            float _25;
            float3 _26;
            bool _29;
            float3 _30;
            float3 _31;
            float _32;
            float2 _34;
            float3 _35;
            float _36;
            float _37;
            float _38;
            float _39;
            float _40;
            float _41;
            float _42;
            float _43;
            float _44;
            float _45;
            float _46;
            float _47;
            float _48;
            float _49;
            float _465;
            uint _469;
            float3 _475 = float3(255.0, 255.0, 255.0);
            uint _514;
            float3 _516 = float3(255.0, 255.0, 255.0);

            bool any(float4 v)
            {
                return (v.x != 0.0f) || (v.y != 0.0f) || (v.z != 0.0f) || (v.w != 0.0f);
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 _20;
                _23.x = dot(i.Varying_v4_A.xyz, i.Varying_v4_A.xyz);
                _23.x = rsqrt(_23.x);
                _23 = _23.xxx * i.Varying_v4_A.xyz;
//_23 = normalize(-_WorldSpaceLightPos0.xyz);
                _26 = UnpackNormal(tex2D(_7, i.Varying_v2_C)).xyz;
//_26 = tex2D(_7, i.Varying_v2_C);                
                //_30 = (_26 * float3(2.0, 2.0, 2.0)) + float3(-1.0, -1.0, -1.0);
                _30 = _26;
//_20.xyz = _30;
                _23.x = dot(_23, _30);
//_20.xyz = float3(_23.x, _23.x, _23.x);                
                _23.x = clamp(_23.x, 0.0, 1.0);
                _26.x = tex2D(_8, i.Varying_v2_C).x;
//_20.xyz = float3(_26.x, _26.x, _26.x);                
                _36 = i.Varying_v4_A.w * _52_m17;
                _31 = i.Varying_v3_B + (-_52_m1);
                _39 = dot(_31, _31);
                _39 = rsqrt(_39);
                _31 = float3(_39, _39, _39) * _31;
                _35.x = dot(float3(_52_m9.x, _52_m9.y, _52_m9.z), _31);
                _38 = (_35.x * _52_m5) + (-_52_m5);
                _38 += 1.0;
                _38 = max(_38, 0.0);
                _38 *= _38;
                _30 = _52_m3 + (-_52_m4);
                _30 = (float3(_38, _38, _38) * _30) + _52_m4;
                _38 = dot(_52_m2, _31);
                _44 = _38 * _38;
                _40 = (_44 * 0.16670000553131103515625) + 1.0;
                _40 = _38 * _40;
                _40 *= 0.6366198062896728515625;
                _40 = abs(_40) + 0.014999999664723873138427734375;
                _38 = min(_40, 0.07999999821186065673828125);
                _44 = max(_52_m8, 9.9999997473787516355514526367188e-05);
                _44 = 1.0 / _44;
                _34.x = _44 * _38;
                _34.y = 0.5;
                _41 = tex2Dlod(_9, float4(_34, 0.0, 0.0)).y;
                _46 = (_35.x * 0.5099999904632568359375) + 0.4900000095367431640625;
                _35 = float3(_52_m6.x * _52_m7, _52_m6.y * _52_m7, _52_m6.z * _52_m7);
                _35 = float3(_41, _41, _41) * _35;
                _48 = _46 + (-0.300000011920928955078125);
                _48 *= 1.4285714626312255859375;
                _48 = clamp(_48, 0.0, 1.0);
                _34.x = (_48 * (-2.0)) + 3.0;
                _48 *= _48;
                _37 = _48 * _34.x;
                _43 = abs(_52_m9.y) + (-0.20000000298023223876953125);
                _43 *= 3.3333332538604736328125;
                _43 = clamp(_43, 0.0, 1.0);
                _49 = (_43 * (-2.0)) + 3.0;
                _43 *= _43;
                _43 *= _49;
                _48 = ((-_34.x) * _48) + 1.0;
                _48 = (_43 * _48) + _37;
                _35 = (_35 * float3(_48, _48, _48)) + _30;
                if(_23.x < 0.01)
                {
                    discard;
                }
                return float4(saturate(_26.xxx * _MoonColor.xyz*1.5+0.45), pow(_23.x, _EdgeTransprent) * _MoonAlpha);
                _30 = _26.xxx * _MoonColor.xyz;
                _30 *= float3(_52_m11, _52_m11, _52_m11);
//_20.xyz = _23;               
                _23 = (_30 * _23.xxx) + _35;
//_23 = _MoonColor.xyz;                
//_20.xyz = _23;        
                /*_29 = any(float4(_52_m12, _52_m12, _52_m12, _52_m12));
                if (_29)
                {*/
                    _25 = dot(-_52_m0, -_52_m0);
                    _25 = sqrt(_25);
                    if(_52_m14.y >= _25)
                    {
                        _42 = 1;
                    }else
                    {
                        _42 = 0;
                    }
                    //_42 = _52_m14.y >= _25 ? true : false;
                    _47 = _52_m16;
                    _32 = dot(_23, float3(0.2125000059604644775390625, 0.7153999805450439453125, 0.07209999859333038330078125));
                    _31 = float3(_32 * _52_m13.x, _32 * _52_m13.y, _32 * _52_m13.z);
                    _30 = lerp(_23, _31, _47);
                    _45 = (-_52_m14.z) + 1.0;
                    _25 = ((-_52_m14.y) * _45) + _25;
                    _45 = (_52_m14.y * _52_m14.z) + 9.9999997473787516355514526367188e-05;
                    _25 /= _45;
                    _25 = clamp(_25, 0.0, 1.0);
                    _44 = (_25 * (-_52_m15.x)) + _52_m15.x;
                    _44 = clamp(_44, 0.0, 1.0);
                    _30 = (-_23) + _30;
                    _30 = (float3(_44, _44, _44) * _30) + _23;
                    //_23 = lerp(_23, _30, _42);
                //}
                //_20 = float4(_23.x, _23.y, _23.z, _20.w);
_20 = float4(_30, _20.w);                
                _20.w = _36;
//_20.w = 1.0;
                //return half4(0,0,0,1);
                return _20;
            }
            ENDCG
        }
    }
}

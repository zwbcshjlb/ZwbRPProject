using System;
using System.Collections.Generic;
using System.ComponentModel;
using UnityEngine;

[ExecuteAlways]
public class GenshipSkyParams : MonoBehaviour
{
    public Light DirectionLightt;
    public bool m_alwaysUpdate;

    public float _LightIntensity = 1.0f;

    public bool _Day = false;
    public Color _DirLightColor = new Color(0.3515625f,0.578125f,1.0f,1.0f);
    //Communal共用参数
    [Header("------------------------共用参数-------------------------")]
    [Header("_IrradianceMapR Rayleigh Scatter")]
    public Color _TopAroundSunColor = new Color(0.00326f,0.18243f,0.63132f,1.0f);
    public Color _TopSkyColor = new Color(0.1041798f, 0.105746f, 0.1888139f);
    // [ColorUsage(false, true)]
    public Color _MiddleAroundSunColor = new Color(0.8657666f, 0.1706658f, 0.01984066f);
    public Color _MiddleSkyColor = new Color(0.4774929f, 0.3099873f, 0.2036164f);
    [Range(0, 2)]
    public float _AroundSunHaloSize = 0.3044474f;
    [Range(0, 1)]
    public float _MiddleSkyArea = 0.4586129f;

    [Header("_IrradianceMapG Mie Scatter")]
    public Color _SunsetMorningGlowColor = new Color(0.975133f, 0.7354551f, 0.3996257f);
    [Range(0, 3)]
    public float _SunsetMorningGlowIntensity = 1.206624f;
    [Range(0, 1)]
    public float _IrradianceMapG_maxAngleRange = 0.6607388f;

    [Header("Sun Disk")] 
    [Range(0, 1000)]
    public float _SunHaloSize = 351.1657f;
    public Color _SunHaloColor = new Color(0.891852f, 0.4535326f, 0.1378029f);
    [Range(0, 10)]
    public float _SunHaloIntensity = 1.163067f;

    [Header("Moon")] 
    [Range(0, 1)] 
    public float _MoonBrightness = 0.5f;
    [Range(0, 1)] 
    public float _MoonBrightnessMax = 0.19794f;
    
    //Skybox
    [Header("------------------------天空盒-------------------------")]
    [Header("Moon")]
    public Color _MoonColor = new Color(0.1884468f, 0.3297098f, 0.4767046f);
    [Range(0, 10)] 
    public float _MoonSize = 0.19794f;
    [Range(0, 4)] 
    public float _MoonColorIntensity = 3.29897f;
    
    [Header("Star")] 
    [Range(0, 1)]
    public float _StarIntensity = 0.7692237f;
    [Range(0, 1)] 
    public float _starNumberIntensity = 0.002921373f;
    [Range(0, 1)] 
    public float _NoiseSpeed = 0.293f;

    //Cloud
    [Header("------------------------云层-------------------------")]
    [Header("Cloud Transmission")]
    [Range(0, 10)]
    public float _SunLightTrasmi = 8.325501f;
    [Range(0, 10)]
    public float _MoonLightTrasmi = 1.706602f;
    [Range(0, 1)]
    public float _CloudTransmiIntensity = 0.8990098f;
    
    [Header("Cloud Color")]
    public Color _SunShineColor = new Color(0.9558311f, 0.5051994f, 0.3502946f);
    public Color _MoonShineColor = new Color(0.07832335f, 0.0869457f, 0.103671f);
    public Color _DayCloudInSunColor = new Color(0.8181017f, 0.3913187f, 0.2937731f);
    public Color _DayCloudSunAroundColor = new Color(0.907616f, 0.5119854f, 0.3548318f);
    public Color _NightCloundInSunColor = new Color(0.2369859f, 0.2321503f, 0.2780426f);
    public Color _NightCloudSunAroundColor = new Color(0.04807252f, 0.1417156f, 0.3348806f);
    [Range(0, 2)]
    public float _AroundSunSize = 0.2860512f;
    [Range(0, 1)]
    public float _CloudColorIntersity = 0.481812f;
    public float _CloudNoiseOffset = 55.26278f;
    public float _CloudNoiseScale = 0.0123f;

    [Header("Galaxy")]
    [Range(0, 1)]
    public float _GalaxyAlpha = 1.0f;
    
    [Header("Misc")]
    public Vector3 _sun_dir = new Vector3(0.4804857f, 0.1503147f, -0.8640248f);
    public Vector3 _moon_dir = new Vector3(-0.7006048f, -0.06914657f, -0.7101912f);
    
    [Header("OtherControl")] 
    public Transform _sunTransform;
    public Transform _moonTransform;

    [Header("Materials")] 
    public List<Renderer> _skyRenderers = new List<Renderer>();
    public List<Renderer> _cloudRenderers = new List<Renderer>();
    public Renderer _galaxyRenderer = new Renderer();

    private void Start()
    {
        // Light directionalLight = FindObjectOfType<Light>();
        //
        // if (directionalLight != null && directionalLight.type == LightType.Directional)
        // {
        //     // 获取定向光源的方向
        //     Vector3 direction = -directionalLight.transform.forward;
        //
        //     _moon_dir = direction;
        //     _sun_dir = -direction;
        // }
        // else
        // {
        //     Debug.Log("No directional light found in the scene.");
        // }
    }

    private void SetCommonProperties(MaterialPropertyBlock mpb)
    {
        mpb.SetColor(nameof(_TopAroundSunColor), _TopAroundSunColor);
        mpb.SetColor(nameof(_TopSkyColor), _TopSkyColor);
        mpb.SetColor(nameof(_MiddleAroundSunColor), _MiddleAroundSunColor);
        mpb.SetColor(nameof(_MiddleSkyColor), _MiddleSkyColor);
        
        mpb.SetFloat(nameof(_AroundSunHaloSize), _AroundSunHaloSize);
        mpb.SetFloat(nameof(_MiddleSkyArea), _MiddleSkyArea);
        
        mpb.SetColor(nameof(_SunsetMorningGlowColor), _SunsetMorningGlowColor);
        mpb.SetFloat(nameof(_SunsetMorningGlowIntensity), _SunsetMorningGlowIntensity);
        mpb.SetFloat("_SunsetMorningGlowArea", _IrradianceMapG_maxAngleRange);
        
        mpb.SetFloat(nameof(_SunHaloSize), _SunHaloSize);
        mpb.SetColor(nameof(_SunHaloColor), _SunHaloColor);
        mpb.SetFloat(nameof(_SunHaloIntensity), _SunHaloIntensity);
        
        mpb.SetFloat(nameof(_MoonBrightness), _MoonBrightness);
        mpb.SetFloat(nameof(_MoonBrightnessMax), _MoonBrightnessMax);

        mpb.SetVector("_SunDirection", _sun_dir);
        mpb.SetVector("_MoonDirection", _moon_dir);
    }

    private void SetSkySphereProperties(MaterialPropertyBlock mpb)
    {
        mpb.SetColor(nameof(_MoonColor), _MoonColor);
        mpb.SetFloat(nameof(_MoonSize), _MoonSize);
        mpb.SetFloat(nameof(_MoonColorIntensity), _MoonColorIntensity);
        mpb.SetFloat(nameof(_StarIntensity), _StarIntensity);
        mpb.SetFloat(nameof(_starNumberIntensity), _starNumberIntensity);
        mpb.SetFloat(nameof(_NoiseSpeed), _NoiseSpeed);
    }
    
    private void SetCloudProperties(MaterialPropertyBlock mpb)
    {
        mpb.SetColor(nameof(_SunShineColor), _SunShineColor);
        mpb.SetColor(nameof(_MoonShineColor), _MoonShineColor);
        
        mpb.SetFloat(nameof(_SunLightTrasmi), _SunLightTrasmi);
        mpb.SetFloat(nameof(_MoonLightTrasmi), _MoonLightTrasmi);
        mpb.SetFloat(nameof(_CloudTransmiIntensity), _CloudTransmiIntensity);
        
        mpb.SetColor(nameof(_DayCloudInSunColor), _DayCloudInSunColor);
        mpb.SetColor(nameof(_DayCloudSunAroundColor), _DayCloudSunAroundColor);
        mpb.SetColor(nameof(_NightCloundInSunColor), _NightCloundInSunColor);
        mpb.SetColor(nameof(_NightCloudSunAroundColor), _NightCloudSunAroundColor);
        
        mpb.SetFloat(nameof(_AroundSunSize), _AroundSunSize);
        mpb.SetFloat(nameof(_CloudColorIntersity), _CloudColorIntersity);
        mpb.SetFloat(nameof(_CloudNoiseOffset), _CloudNoiseOffset);
        mpb.SetFloat(nameof(_CloudNoiseScale), _CloudNoiseScale);
    }

    private void Update()
    {
        if (!m_alwaysUpdate)
            return;
        
        Vector3 pos = transform.position;
        if (_sunTransform != null)
        {
            Vector3 sun_dir = (_sunTransform.position - pos).normalized;
            _sun_dir = sun_dir;
        }

        if (_moonTransform != null)
        {
            Vector3 moon_dir = (_moonTransform.position - pos).normalized;
            _moon_dir = moon_dir;
        }
        
        foreach (var renderer1 in _skyRenderers)
        {
            if (renderer1 == null)
                continue;
            MaterialPropertyBlock mpb = new MaterialPropertyBlock();
            renderer1.GetPropertyBlock(mpb);
        
            SetCommonProperties(mpb);
            SetSkySphereProperties(mpb);
        
            renderer1.SetPropertyBlock(mpb);
        }
        
        foreach (var renderer1 in _cloudRenderers)
        {
            if (renderer1 == null)
                continue;
            MaterialPropertyBlock mpb = new MaterialPropertyBlock();
            renderer1.GetPropertyBlock(mpb);
        
            SetCommonProperties(mpb);
            SetCloudProperties(mpb);
        
            renderer1.SetPropertyBlock(mpb);
        }
        
        MaterialPropertyBlock galaxyMPB = new MaterialPropertyBlock();
        _galaxyRenderer.GetPropertyBlock(galaxyMPB);
        galaxyMPB.SetFloat(nameof(_GalaxyAlpha), _GalaxyAlpha);
        _galaxyRenderer.SetPropertyBlock(galaxyMPB);

        if (_Day)
        {
            DirectionLightt.transform.forward = -_sun_dir;
        }
        else
        {
            DirectionLightt.transform.forward = -_moon_dir;
        }
        DirectionLightt.intensity = _LightIntensity;
        DirectionLightt.color = _DirLightColor;
    }
}
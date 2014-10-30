// =================================================================================================
//	Life Cycle Framework for native android
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================
package com.gazman.life_cycle;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;

class ClassConstructor {
	
	private static HashMap<Class<?>, HashMap<String, Object>> singltons = new HashMap<Class<?>, HashMap<String,Object>>();
	
	@SuppressWarnings("unchecked")
	public static <T> T construcSingleTon(String family, Class<?> clasToUse, Object... params) {
		HashMap<String,Object> map = singltons.get(clasToUse);
		if(map == null){
			map = new HashMap<String, Object>();
			singltons.put(clasToUse, map);
		}
		Object instance = map.get(family);
		if(instance == null){
			if(params.length > 0){
				instance = construct(family, clasToUse, params);
			}
			else{
				instance = construct(family, clasToUse);
			}
			map.put(family, instance);
			if (instance instanceof Injector) {
				((Injector) instance).injectionHandler(family);
			}
		}
		return (T) instance;
	}

	@SuppressWarnings("unchecked")
	public static <T> T construct(String family, Class<?> clasToUse) {
		try {
			return (T) clasToUse.newInstance();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
		throw new IllegalStateException("Injection faild");
	}
	
	@SuppressWarnings("unchecked")
	public static <T> T construct(String family, Class<?> clasToUse, Object... params) {
		Constructor<?>[] constructors = clasToUse.getConstructors();
		for (Constructor<?> constructor : constructors) {
			try {
				Class<?>[] parameterTypes = constructor.getParameterTypes();
				if (parameterTypes.length != params.length) {
					continue;
				}
				return (T) constructor.newInstance(params);
				
			} catch (InstantiationException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
		}
		throw new IllegalStateException("Injection faild");
	}
}

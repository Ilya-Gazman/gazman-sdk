// =================================================================================================
//	Life Cycle Framework for native android
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================
package com.gazman.life_cycle;

import java.util.HashMap;
import java.util.LinkedList;

import com.gazman.life_cycle.signal.RegistrationCompleteSignal;

public abstract class Registrator {
	static HashMap<Class<?>, HashMap<String, Class<?>>> classsesMap = new HashMap<Class<?>, HashMap<String, Class<?>>>();
	// GUID value
	static final String DEFAULT_FAMILY = "de9502c7-a41a-4fdb-9d42-249b94fbeaa9";

	private static LinkedList<Registrator> registrators = new LinkedList<Registrator>();
	private static boolean initilizationComplete = false;

	/**
	 * The entry point to the initialization process
	 */
	public void initilize() {
		if (initilizationComplete) {
			throw new IllegalStateException(
					"Initilization process has already been excecuted.");
		}
		initilizationComplete = true;
		initRegistrators();
		for (Registrator registrator : registrators) {
			registrator.initClasses();
		}
		initClasses();
		for (Registrator registrator : registrators) {
			registrator.initSignals();
		}
		initSignals();
		registrators = null;
		Factory.inject(RegistrationCompleteSignal.class)
				.registrationCompleteHandler();
	}

	/**
	 * Will call {@link #registerClass(Class, Class, String)} with <br>
	 * registerClass(claz, Object.class, DEFAULT_FAMILY)
	 * 
	 * @param claz
	 *            the class tree to register
	 */
	protected void registerClass(Class<?> claz) {
		registerClass(claz, Object.class, DEFAULT_FAMILY);
	}

	/**
	 * Will call {@link #registerClass(Class, Class, String)} with <br>
	 * registerClass(claz, Object.class, family)
	 * 
	 * @param claz
	 *            the class tree to register
	 */
	protected void registerClass(Class<?> claz, String family) {
		registerClass(claz, Object.class, family);
	}

	/**
	 * Will call {@link #registerClass(Class, Class, String)} with <br>
	 * registerClass(claz, topClaz, family)
	 * 
	 * @param claz
	 *            the class tree to register
	 */
	protected <T, X extends T> void registerClass(Class<X> claz,
			Class<T> topClaz) {
		registerClass(claz, topClaz, DEFAULT_FAMILY);
	}

	/**
	 * When any class from @claz super family up to @topClaz will be injected @claz
	 * will be created.
	 * 
	 * @param claz
	 *            claz the class tree to register
	 * @param topClaz
	 * @param family
	 */
	protected <T, X extends T> void registerClass(Class<X> claz,
			Class<T> topClaz, String family) {
		if (family == null) {
			family = DEFAULT_FAMILY;
		}
		@SuppressWarnings("unchecked")
		Class<? super T> superclass = (Class<? super T>) claz;
		while (superclass != topClaz) {
			HashMap<String, Class<?>> hashMap = classsesMap.get(superclass);
			if (hashMap == null) {
				hashMap = new HashMap<String, Class<?>>();
				classsesMap.put(superclass, hashMap);
			}
			hashMap.put(family, claz);
			// next
			superclass = superclass.getSuperclass();
		}

	}

	/**
	 * Register handler class to signal, even if the handler is not a Singleton,
	 * it will be the same handler instance that will handle all the dispatches
	 * of that signal
	 * 
	 * @param signal The signal class
	 * @param handler The handler class
	 */
	protected <T> void registerToSignal(Class<? extends Signal<T>> signal,
			Class<T> handler) {
		registerToSignal(signal, handler, Registrator.DEFAULT_FAMILY);
	}
	
	/**
	 * Register handler class to signal, even if the handler is not a Singleton,
	 * it will be the same handler instance that will handle all the dispatches
	 * of that signal
	 * 
	 * @param signal The signal class
	 * @param handler The handler class
	 */
	protected <T> void registerToSignal(Class<? extends Signal<T>> signal,
			Class<T> handler, String family) {
		if(family !=  Registrator.DEFAULT_FAMILY && !ISingleTon.class.isAssignableFrom(handler) ){
			throw new IllegalStateException("handler must be single ton other wise don't use family.");
		}
		Signal<T> signalInstance = Factory.inject(signal, family);
		T handlerInstance = Factory.inject(handler, family);
		signalInstance.addListener(handlerInstance);
	}

	protected void addRegistrator(Registrator registrator) {
		registrators.add(registrator);
		registrator.initRegistrators();
	}

	/**
	 * A place to make all your {@link #registerClass(Class)} calls.
	 */
	protected abstract void initClasses();

	/**
	 * A place to make all your {@link #registerToSignal(Class, Class)} calls.
	 */
	protected abstract void initSignals();

	/**
	 * A place to make all your {@link #addRegistrator(Registrator)} calls. <br>
	 * *Note that order it very important - If you perform class overriding you would prefer to add this Registrator last.
	 */
	protected abstract void initRegistrators();

}

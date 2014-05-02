// =================================================================================================
//	Life Cycle Framework for native android
//	Copyright 2014 Ilya Gazman. All Rights Reserved.
//
//	This is not free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//  https://github.com/Ilya-Gazman/gazman-sdk/blob/master/LICENSE.md
// =================================================================================================
package com.gazman.life_cycle;

import java.lang.reflect.Method;
import java.util.Iterator;
import java.util.LinkedList;


public abstract class Signal<T> implements ISingleTon {
	private Method method;
	private LinkedList<T> listeners = new LinkedList<T>();
	private final Object synObject = new Object();

	protected Signal() {
		Class<?>[] interfaces = getClass().getInterfaces();
		if (interfaces.length != 1) {
			throw new IllegalArgumentException(
					this.getClass()
							+ "Must implement exactly two interfaces, not more and not less. curently implementing "
							+ interfaces.length);
		}
		Method[] methods = interfaces[0].getMethods();
		if (methods.length != 1) {
			throw new IllegalArgumentException(interfaces[0]
					+ "Must have exactly one method, not more and not less");
		}
		method = methods[0];
	}

	protected void dispatch(Object... arguments) {
		Iterator<T> iterator = listeners.iterator();
		while (iterator.hasNext()) {
			T listener;
			synchronized (synObject) {
				if (iterator.hasNext()) {
					listener = iterator.next();
				} else {
					listener = null;
				}
			}
			if (listener != null) {
				invoke(listener, arguments);
			}
		}
	}

	private void invoke(T listener, Object... arguments) {
		if (listener == null) {
			throw new NullPointerException("Listener can't be null");
		}
		try {
			method.invoke(listener, arguments);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public final void addListener(T listener) {
		synchronized (synObject) {
			listeners.add(listener);
		}
	}

	public final void removeListener(T listener) {
		synchronized (synObject) {
			listeners.remove(listener);
		}
	}
}

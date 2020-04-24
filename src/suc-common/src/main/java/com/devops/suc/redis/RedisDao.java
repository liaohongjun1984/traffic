package com.devops.suc.redis;

import java.util.Set;

public interface RedisDao {
	/**
	 * set
	 * @param key
	 * @param value
	 */
	public void set(String key,String value);
	/**
	 * 
	 * @param key
	 * @return
	 */
	public String get(String key);
	/**
	 * 序列化对象
	 * @param key
	 * @param value
	 */
	public void set(String key, byte[] value);
	/**
	 * 获取对象
	 * @param key
	 * @return
	 */
	public byte[] getObject(String key);
	/**
	 * 获取key值
	 * @param pattern
	 * @return
	 */
	public Set<String> keys(String pattern);

	/**
	 * 删除key
	 * @param key
	 */
	public void delKeys(String... key);
	/**
	 * 删除byte的key
	 * @param key
	 */
	public void delByteKeys(String... key);

}

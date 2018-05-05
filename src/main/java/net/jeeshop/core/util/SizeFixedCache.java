package net.jeeshop.core.util;

import java.util.LinkedHashMap;
import java.util.Map;
/**
 * Created by gaoyibin on 2016/7/24.
 */
public class SizeFixedCache<K, V> extends LinkedHashMap<K, V> {
    private static final long serialVersionUID = 8959155076803596737L;

    private int maxSize;

    public SizeFixedCache(int maxSize) {
        super(maxSize, .75f, true);
        this.maxSize = maxSize;
    }

    /**
     * 限制大小不超过maxSize
     *
     * @see LinkedHashMap#removeEldestEntry
     * @param entry
     *            Entry
     * @return boolean
     */
    @Override
    protected boolean removeEldestEntry(Map.Entry<K, V> entry) {
        return size() > maxSize;
    }
}
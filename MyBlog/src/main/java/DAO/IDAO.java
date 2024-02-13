package DAO;

import java.util.Collection;

public interface IDAO<T> {
    public int insert(T t);

    public T select(T t);

    public Collection<T> selectAll();

    public int update(T t);

    public int delete(T t);
}

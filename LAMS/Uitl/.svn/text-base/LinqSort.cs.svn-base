#region Description
/*================================================================================
 *  Copyright (c) SunTek.  All rights reserved.
 * ===============================================================================
 * Solution: LAMS
 * Module:  Uitl
 * Descrption:Linq动态排序
 * CreateDate: 2010/11/23
 * Author: hgq
 * Version:1.0
 * ===============================================================================*/
#endregion
using System;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;

namespace SunTek.LAMS.Uitl
{
    public static class LinqSort
    {
        /// <summary>
        /// Linq动态排序
        /// </summary>
        /// <typeparam name="T">T</typeparam>
        /// <param name="source">要排序的数据源</param>
        /// <param name="value">排序依据（加空格）排序方式</param>
        /// <returns>IOrderedQueryable</returns>
        public static IOrderedQueryable<T> OrderBy<T>(this IQueryable<T> source, string value)
        {
            string[] arr = value.Split(' ');
            string Name = arr[1].ToUpper() == "DESC" ? "OrderByDescending" : "OrderBy";
            return ApplyOrder<T>(source, arr[0], Name);
        }
        /// <summary>
        /// Linq动态排序再排序
        /// </summary>
        /// <typeparam name="T">T</typeparam>
        /// <param name="source">要排序的数据源</param>
        /// <param name="value">排序依据（加空格）排序方式</param>
        /// <returns>IOrderedQueryable</returns>
        public static IOrderedQueryable<T> ThenBy<T>(this IOrderedQueryable<T> source, string value)
        {
            string[] arr = value.Split(' ');
            string Name = arr[1].ToUpper() == "DESC" ? "ThenByDescending" : "ThenBy";
            return ApplyOrder<T>(source, arr[0], Name);
        }
        static IOrderedQueryable<T> ApplyOrder<T>(IQueryable<T> source, string property, string methodName)
        {
            Type type = typeof(T);
            ParameterExpression arg = Expression.Parameter(type, "a");
            PropertyInfo pi = type.GetProperty(property);
            Expression expr = Expression.Property(arg, pi);
            type = pi.PropertyType;
            Type delegateType = typeof(Func<,>).MakeGenericType(typeof(T), type);
            LambdaExpression lambda = Expression.Lambda(delegateType, expr, arg);
            object result = typeof(Queryable).GetMethods().Single(
            a => a.Name == methodName
            && a.IsGenericMethodDefinition
            && a.GetGenericArguments().Length == 2
            && a.GetParameters().Length == 2).MakeGenericMethod(typeof(T), type).Invoke(null, new object[] { source, lambda });
            return (IOrderedQueryable<T>)result;
        }
    }
}



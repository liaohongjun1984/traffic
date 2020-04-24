import java.util.List;

import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.core.type.classreading.MetadataReaderFactory;
import org.springframework.core.type.classreading.SimpleMetadataReaderFactory;
import org.springframework.util.ClassUtils;
import org.springframework.util.SystemPropertyUtils;

import com.idhoo.dhutil.resource.ClassDesc;
import com.idhoo.dhutil.resource.SearchResource;


public class TestMain {
	protected static final String DEFAULT_RESOURCE_PATTERN = "**/*.*";
    /* 资源解析器 */ 
    private static final ResourcePatternResolver RESOLVER       = new PathMatchingResourcePatternResolver(); 
   /* Meta信息Reader Factory.用于创建MetaReader */ 
   private static final MetadataReaderFactory   READER_FACTORY = new SimpleMetadataReaderFactory(); 

   public static void main(String[] args) throws Exception { 
//	   try{
//		  System.out.println("being");
//	   	  Class<?> z = Class.forName("com.duowan.yy.sysop.suc.actions.AppAction");
//	   	  System.out.println(z.isAnnotationPresent(ClassResourceDesc.class));
//	   	  ClassResourceDesc crd = z.getAnnotation(ClassResourceDesc.class);
//	   	  System.out.println(crd.firstCate());
//		  Annotation[] ans = z.getAnnotations();
//		  for(Annotation an : ans){
//			  System.out.println(an.getClass().getName());
//		  }
//	   }catch(Exception e){
//		   e.printStackTrace();
//	   }
	   List<ClassDesc> a = SearchResource.getResourceDesc();
	   
	   System.out.println(a);
//	   Package[] allPackage = Package.getPackages();
//	   for(Package p : allPackage){
//		   System.out.println(p.getName());
//	   }
//	   String packageSearchPath = ResourcePatternResolver.CLASSPATH_ALL_URL_PREFIX + resolveBasePackage("org") + "/" + DEFAULT_RESOURCE_PATTERN;
//	   System.out.println(packageSearchPath);
//	   System.exit(-1);
//       //根据正则表达式,得到资源列表 
//       Resource[] resources = RESOLVER.getResources(packageSearchPath); 
//       System.out.println("resources:"+resources.length);
//       for (Resource res : resources) { 
//    	   System.out.println(res);
//           //通过 MetadataReader得到ClassMeta信息,打印类名 
////           MetadataReader meta = READER_FACTORY.getMetadataReader(res); 
////           System.out.println(meta); 
//       } 
   } 
	/**
	 * Resolve the specified base package into a pattern specification for
	 * the package search path.
	 * <p>The default implementation resolves placeholders against system properties,
	 * and converts a "."-based package path to a "/"-based resource path.
	 * @param basePackage the base package as specified by the user
	 * @return the pattern specification to be used for package searching
	 */
	protected static String resolveBasePackage(String basePackage) {
		return ClassUtils.convertClassNameToResourcePath(SystemPropertyUtils.resolvePlaceholders(basePackage));
	}
}

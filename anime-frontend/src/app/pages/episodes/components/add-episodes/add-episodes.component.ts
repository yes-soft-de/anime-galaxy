import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Observable } from 'rxjs';
import { map, mergeMap } from 'rxjs/operators';
import { TokenService } from 'src/app/pages/admin-service/token/token.service';
import { AnimesResponse } from 'src/app/pages/animes/entity/animes-response';
import { AnimeService } from 'src/app/pages/animes/services/anime.service';
import { ListCategoryResponse } from 'src/app/pages/categories/entity/list-category-response';
import { CategoryService } from 'src/app/pages/categories/services/category.service';
import { ImageSnippet } from '../../entity/image-snippet';
import { EpisodesService } from '../../services/episodes.service';
import { Options } from 'select2';


@Component({
  selector: 'app-add-episodes',
  templateUrl: './add-episodes.component.html'
})
export class AddEpisodesComponent implements OnInit {
  mergeResult: {
    animes: AnimesResponse
    categories: ListCategoryResponse,
  }
  // allCategories: ListCategory[];
  isSubmitted = false;
  uploadForm: FormGroup;
  uploadButtonValue = 'Upload';
  mainUploadButtonValue = 'Upload';
  imageName = 'Select Image';
  mainImageName = 'Select Main Image';
  fileSelected = false;
  mainFileSelected = false;
  fileUploaded = false;
  imageUrl: string;
  mainImageUrl: string;
  imagePathReady = false;
  mainImagePathReady = false;
  submitButtonValue = 'Waiting Uploading Image';
  selectedFile: ImageSnippet;
  public selectData: Array<{ id: string; text: string; }> = [];
  public options: Options;
  public value: string[] = [];


  constructor(private episodeService: EpisodesService,
              private tokenService: TokenService,
              private animeService: AnimeService,
              private categoryService: CategoryService,
              private formBuilder: FormBuilder,
              private toaster: ToastrService,
              private router: Router,
              private activatedRoute: ActivatedRoute) {
  }

  ngOnInit() {
    const animes: Observable<AnimesResponse> = this.animeService.allAnimes();
    const categories: Observable<ListCategoryResponse> = this.categoryService.allCategories();
    const result: Observable<any> = animes.pipe(
      mergeMap(animesResponse => {
        return categories.pipe(
          map(categoriesResponse => {
            const result = {
              animes: animesResponse,
              categories: categoriesResponse
            };
            return result;
        }))
      })
    );
    result.subscribe(
      mergeResponse => {
        this.mergeResult = mergeResponse;
        this.mergeResult.categories.Data.map(e => {
          // id : must be as string
          this.selectData.push({id: `${e.id}`, text: e.name});
        });
      }
    );

    // Fetch Form Data
    this.uploadForm = this.formBuilder.group({
      animeID: ['', Validators.required],
      // categoyID: ['', Validators.required],
      categories: [''],
      seasonNumber: ['', [Validators.required, Validators.minLength(1)]],
      episodeNumber: ['', [Validators.required, Validators.minLength(1)]],
      description: ['', Validators.required],
      image: [''],
      posterImage: [''],
      duration: ['', Validators.required],
      publishDate: ['', Validators.required]
    });
    
    // Options For Select 2
    this.options = {
      width: '100%',
      placeholder: 'Type Episodes Categories',
      multiple: true,
      tags: true
    };
  }

  // Choose Anime Using Select Dropdown
  changeAnime(event) {
    this.uploadForm.get('animeID').setValue(event.target.value, {
      onlySelf: true
    });
  }

  // Choose Category Using Select Dropdown
  // changeCategory(event) {
  //   this.uploadForm.get('categoyID').setValue(event.target.value, {
  //     onlySelf : true
  //   });
  // }


  // Get Image Information
  updateName(imageInput: any) {
    const file: File = imageInput.files[0];
    this.uploadButtonValue = 'Upload';
    this.imageName = file.name;
    this.fileSelected = true;
  }

  updateMainName(imageInput: any) {
    const file: File = imageInput.files[0];
    this.mainUploadButtonValue = 'Upload';
    this.mainImageName = file.name;
    this.mainFileSelected = true;
  }


  // Upload Image
  processFile(imageInput: any) {
    this.fileSelected = false;
    this.uploadButtonValue = 'Uploading...';
    console.log('Processing File');
    const file: File = imageInput.files[0];
    const reader = new FileReader();
    
    reader.addEventListener('load', (event: any) => {
      this.selectedFile = new ImageSnippet(event.target.result, file);
      this.animeService.uploadImage(this.selectedFile.file).subscribe(
        (res) => {
          this.imageUrl = res;
          this.uploadButtonValue = 'Uploaded';
          this.imagePathReady = true;
          this.submitButtonValue = 'New Episode';          
        },
        (err) => {
          console.log(err);
        });
    });
    reader.readAsDataURL(file);
  }


  processMainFile(imageInput: any) {
    this.mainFileSelected = false;
    this.mainUploadButtonValue = 'Uploading...';
    console.log('Processing File');
    const file: File = imageInput.files[0];
    const reader = new FileReader();
    
    reader.addEventListener('load', (event: any) => {
      this.selectedFile = new ImageSnippet(event.target.result, file);
      this.animeService.uploadImage(this.selectedFile.file).subscribe(
        (res) => {
          console.log(res);
          this.mainImageUrl = res;
          this.mainUploadButtonValue = 'Uploaded';
          this.mainImagePathReady = true;
          this.submitButtonValue = 'New Episode';        
        },
        (err) => {
          console.log(err);
        });
    });
    reader.readAsDataURL(file);
  }


  mySubmit() {
    this.isSubmitted = true;
    if (!this.uploadForm.valid) {
      this.toaster.error('Error : Form Not Valid');
      return false;
    } else {
      // Fetch All Form Data On Json Type
      const formObject = this.uploadForm.getRawValue();
      // formObject.suggest = this.uploadForm.value.suggest == 1 ? true : false;
      formObject.createdBy = this.tokenService.userName;
      formObject.categories = this.value;
      if (this.value.length == 0) {
        this.toaster.error('Error : Category Not Selected, Please Select One');
        this.isSubmitted = false;
        return false;
      }
      formObject.image = this.imageUrl;      
      formObject.posterImage = this.mainImageUrl;  
      this.episodeService.createEpisode(formObject).subscribe(
        (createResponse: any) => console.log(createResponse),
        error => {
          this.isSubmitted = false;
          console.log('Error : ', error);
        },
        () => {
          this.router.navigate(['../'], {relativeTo: this.activatedRoute});
        }
      );
    }
  }

}
